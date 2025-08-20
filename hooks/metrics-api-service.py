#!/usr/bin/env python3
# /// script
# requires-python = ">=3.9"
# dependencies = [
#     "psutil>=5.9.0",
# ]
# description = "Metrics API Service for Claude Framework - PEP 723 compliant daemon service"
# authors = [{name = "Claude Hooks Developer", email = "hooks@claude.ai"}]
# license = {text = "MIT"}
# ///
"""
Metrics API Service for Claude Framework

A PEP 723 compliant daemon service that provides robust metric collection capabilities
for the Claude Framework dashboard system. Implements proper error handling, logging,
exit codes, JSON validation, and security patterns.

This service integrates with the framework's metrics collection system and can be
called by macOS LaunchAgent or other system schedulers.

Exit Codes:
    0: Success
    1: General error (non-blocking)
    2: Blocking error (requires intervention)
    3: Configuration error
    4: Permission error
    5: Timeout error
"""

import json
import logging
import os
import signal
import subprocess
import sys
import time
from datetime import datetime
from pathlib import Path
from typing import Any, Dict, Optional, Tuple

# Configure structured logging
logging.basicConfig(
    level=logging.INFO,
    format='%(asctime)s - %(name)s - %(levelname)s - %(message)s',
    handlers=[
        logging.FileHandler('/Users/nalve/.claude/logs/metrics-api-service.log'),
        logging.StreamHandler(sys.stdout)
    ]
)
logger = logging.getLogger(__name__)

# Global flag for graceful shutdown
shutdown_requested = False


def signal_handler(signum: int, frame) -> None:
    """Handle SIGTERM and SIGINT for graceful shutdown."""
    global shutdown_requested
    logger.info(f"Received signal {signum}, initiating graceful shutdown")
    shutdown_requested = True


def validate_framework_structure() -> Tuple[bool, str]:
    """Validate that the Claude Framework structure exists and is accessible.
    
    Returns:
        Tuple of (is_valid, error_message)
    """
    framework_root = Path("/Users/nalve/.claude")
    
    if not framework_root.exists():
        return False, "Claude Framework root directory not found"
    
    if not framework_root.is_dir():
        return False, "Claude Framework root is not a directory"
    
    # Check for essential directories
    essential_dirs = ["core", "logs", "system"]
    for dir_name in essential_dirs:
        dir_path = framework_root / dir_name
        if not dir_path.exists():
            return False, f"Essential directory missing: {dir_name}"
    
    # Check collector script exists
    collector_path = framework_root / "core" / "dashboard" / "scripts" / "collect_metrics.py"
    if not collector_path.exists():
        return False, "Metrics collector script not found"
    
    # Check permissions
    if not os.access(collector_path, os.R_OK):
        return False, "Cannot read metrics collector script"
    
    return True, ""


def validate_json_input(data: str) -> Tuple[bool, Optional[Dict[str, Any]], str]:
    """Validate and parse JSON input data.
    
    Args:
        data: Raw JSON string
        
    Returns:
        Tuple of (is_valid, parsed_data, error_message)
    """
    if not data or not data.strip():
        return True, None, ""  # Empty input is valid
    
    try:
        parsed = json.loads(data)
        
        # Basic validation of structure if data exists
        if isinstance(parsed, dict):
            # Validate known configuration keys
            allowed_keys = {"timeout", "output_format", "include_performance", "debug"}
            invalid_keys = set(parsed.keys()) - allowed_keys
            if invalid_keys:
                return False, None, f"Invalid configuration keys: {invalid_keys}"
                
            # Validate timeout value
            if "timeout" in parsed:
                timeout = parsed["timeout"]
                if not isinstance(timeout, (int, float)) or timeout <= 0 or timeout > 300:
                    return False, None, "Timeout must be a positive number <= 300 seconds"
        
        return True, parsed, ""
        
    except json.JSONDecodeError as e:
        return False, None, f"Invalid JSON: {e}"
    except Exception as e:
        return False, None, f"JSON validation error: {e}"


def sanitize_output_path(output_path: str) -> Tuple[bool, str, str]:
    """Sanitize and validate output file paths.
    
    Args:
        output_path: Requested output path
        
    Returns:
        Tuple of (is_safe, sanitized_path, error_message)
    """
    try:
        path = Path(output_path).resolve()
        framework_root = Path("/Users/nalve/.claude").resolve()
        
        # Ensure path is within framework directory
        if not str(path).startswith(str(framework_root)):
            return False, "", "Output path must be within Claude Framework directory"
        
        # Ensure parent directory exists or can be created
        path.parent.mkdir(parents=True, exist_ok=True)
        
        # Check write permissions
        if path.exists() and not os.access(path, os.W_OK):
            return False, "", "No write permission for output path"
        
        return True, str(path), ""
        
    except Exception as e:
        return False, "", f"Path validation error: {e}"


def collect_metrics_safe(config: Optional[Dict[str, Any]] = None) -> Tuple[int, str, str]:
    """Safely execute metrics collection with proper error handling.
    
    Args:
        config: Optional configuration dictionary
        
    Returns:
        Tuple of (exit_code, stdout, stderr)
    """
    try:
        # Set default timeout
        timeout = 30
        if config and "timeout" in config:
            timeout = min(config["timeout"], 300)  # Cap at 5 minutes
        
        # Build command
        framework_root = Path("/Users/nalve/.claude")
        collector_path = framework_root / "core" / "dashboard" / "scripts" / "collect_metrics.py"
        
        cmd = [sys.executable, str(collector_path)]
        
        # Set environment variables for security
        env = os.environ.copy()
        env["PYTHONDONTWRITEBYTECODE"] = "1"
        env["PYTHONUNBUFFERED"] = "1"
        
        logger.info(f"Executing metrics collection with timeout: {timeout}s")
        
        # Execute with timeout and security constraints
        result = subprocess.run(
            cmd,
            capture_output=True,
            text=True,
            timeout=timeout,
            env=env,
            cwd=str(framework_root),
            stdin=subprocess.DEVNULL  # Prevent stdin injection
        )
        
        return result.returncode, result.stdout, result.stderr
        
    except subprocess.TimeoutExpired:
        error_msg = f"Metrics collection timed out after {timeout}s"
        logger.error(error_msg)
        return 5, "", error_msg
        
    except PermissionError as e:
        error_msg = f"Permission denied: {e}"
        logger.error(error_msg)
        return 4, "", error_msg
        
    except FileNotFoundError as e:
        error_msg = f"Required file not found: {e}"
        logger.error(error_msg)
        return 3, "", error_msg
        
    except Exception as e:
        error_msg = f"Unexpected error during metrics collection: {e}"
        logger.error(error_msg)
        return 1, "", error_msg


def generate_status_report(exit_code: int, stdout: str, stderr: str) -> Dict[str, Any]:
    """Generate structured status report in JSON format.
    
    Args:
        exit_code: Process exit code
        stdout: Standard output
        stderr: Standard error
        
    Returns:
        Dictionary containing status report
    """
    status_map = {
        0: "success",
        1: "error",
        2: "blocked", 
        3: "configuration_error",
        4: "permission_error",
        5: "timeout_error"
    }
    
    return {
        "timestamp": datetime.now().isoformat(),
        "service": "metrics-api-service",
        "version": "1.0.0",
        "status": status_map.get(exit_code, "unknown"),
        "exit_code": exit_code,
        "output": stdout.strip() if stdout else "",
        "error": stderr.strip() if stderr else "",
        "framework_root": "/Users/nalve/.claude",
        "execution_time": time.time()
    }


def main() -> int:
    """Main service function with comprehensive error handling and logging.
    
    Returns:
        Exit code (0=success, >0=error)
    """
    # Set up signal handlers for graceful shutdown
    signal.signal(signal.SIGTERM, signal_handler)
    signal.signal(signal.SIGINT, signal_handler)
    
    start_time = time.time()
    logger.info("Metrics API Service starting")
    
    try:
        # Check for shutdown signal
        if shutdown_requested:
            logger.info("Shutdown requested during startup")
            return 0
        
        # Validate framework structure
        is_valid, error_msg = validate_framework_structure()
        if not is_valid:
            logger.error(f"Framework validation failed: {error_msg}")
            return 3
        
        # Read and validate JSON input if available
        config = None
        if not sys.stdin.isatty():
            try:
                stdin_data = sys.stdin.read().strip()
                if stdin_data:
                    is_valid, config, error_msg = validate_json_input(stdin_data)
                    if not is_valid:
                        logger.error(f"JSON validation failed: {error_msg}")
                        return 3
            except Exception as e:
                logger.error(f"Failed to read stdin: {e}")
                return 1
        
        # Check for shutdown signal
        if shutdown_requested:
            logger.info("Shutdown requested during initialization")
            return 0
        
        # Execute metrics collection
        exit_code, stdout, stderr = collect_metrics_safe(config)
        
        # Generate and log status report
        status_report = generate_status_report(exit_code, stdout, stderr)
        
        if exit_code == 0:
            logger.info("Metrics collection completed successfully")
            print("Metrics collection completed successfully")
        else:
            logger.warning(f"Metrics collection completed with warnings/errors: {stderr}")
            if stderr:
                print(f"Metrics collection warning: {stderr}")
        
        # Log execution time
        execution_time = time.time() - start_time
        logger.info(f"Service execution completed in {execution_time:.2f}s")
        
        return exit_code
        
    except KeyboardInterrupt:
        logger.info("Service interrupted by user")
        return 0
        
    except Exception as e:
        logger.error(f"Unhandled exception in main: {e}", exc_info=True)
        return 1
    
    finally:
        # Cleanup logging
        logging.shutdown()


if __name__ == "__main__":
    sys.exit(main())