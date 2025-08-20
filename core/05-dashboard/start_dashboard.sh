#!/bin/bash
#
# Claude Framework Dashboard Startup Script
#
# Starts the dashboard server and opens it in the default browser.
# Handles dependencies, port checking, and error recovery.
#

# Configuration
DASHBOARD_HOST="127.0.0.1"
DASHBOARD_PORT="8080"
FRAMEWORK_ROOT="/Users/nalve/.claude"
SCRIPTS_DIR="${FRAMEWORK_ROOT}/system/dashboard/scripts"
DASHBOARD_URL="http://${DASHBOARD_HOST}:${DASHBOARD_PORT}"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Function to check if port is available
check_port() {
    local port=$1
    if lsof -Pi :$port -sTCP:LISTEN -t >/dev/null 2>&1; then
        return 1  # Port is in use
    else
        return 0  # Port is available
    fi
}

# Function to find available port
find_available_port() {
    local start_port=$1
    local port=$start_port
    
    while [ $port -le $((start_port + 100)) ]; do
        if check_port $port; then
            echo $port
            return 0
        fi
        port=$((port + 1))
    done
    
    echo -1
    return 1
}

# Function to check dependencies
check_dependencies() {
    print_status "Checking dependencies..."
    
    # Check Python 3
    if ! command -v python3 &> /dev/null; then
        print_error "Python 3 is required but not installed"
        return 1
    fi
    
    # Check framework structure
    if [ ! -d "$FRAMEWORK_ROOT" ]; then
        print_error "Framework root not found: $FRAMEWORK_ROOT"
        return 1
    fi
    
    if [ ! -d "$SCRIPTS_DIR" ]; then
        print_error "Dashboard scripts directory not found: $SCRIPTS_DIR"
        return 1
    fi
    
    # Check script permissions
    for script in collect_metrics.py health_check.py dashboard_api.py; do
        if [ ! -x "$SCRIPTS_DIR/$script" ]; then
            print_warning "Making $script executable..."
            chmod +x "$SCRIPTS_DIR/$script"
        fi
    done
    
    print_success "Dependencies check completed"
    return 0
}

# Function to start dashboard server
start_server() {
    local port=$1
    
    print_status "Starting Claude Framework Dashboard server on port $port..."
    
    cd "$SCRIPTS_DIR"
    
    # Start server in background
    python3 dashboard_api.py --host "$DASHBOARD_HOST" --port "$port" --framework-root "$FRAMEWORK_ROOT" &
    local server_pid=$!
    
    # Give server time to start
    sleep 3
    
    # Check if server started successfully
    if kill -0 $server_pid 2>/dev/null; then
        print_success "Dashboard server started (PID: $server_pid)"
        echo $server_pid > "/tmp/claude_dashboard_pid"
        return 0
    else
        print_error "Failed to start dashboard server"
        return 1
    fi
}

# Function to open dashboard in browser
open_browser() {
    local url=$1
    
    print_status "Opening dashboard in browser: $url"
    
    # Try different browser opening methods
    if command -v open &> /dev/null; then
        # macOS
        open "$url"
    elif command -v xdg-open &> /dev/null; then
        # Linux
        xdg-open "$url"
    elif command -v start &> /dev/null; then
        # Windows (Git Bash)
        start "$url"
    else
        print_warning "Could not automatically open browser"
        print_status "Please manually open: $url"
    fi
}

# Function to stop existing dashboard
stop_existing() {
    if [ -f "/tmp/claude_dashboard_pid" ]; then
        local existing_pid=$(cat "/tmp/claude_dashboard_pid")
        if kill -0 $existing_pid 2>/dev/null; then
            print_status "Stopping existing dashboard server (PID: $existing_pid)..."
            kill $existing_pid
            sleep 2
            rm -f "/tmp/claude_dashboard_pid"
        fi
    fi
}

# Function to collect initial metrics
collect_metrics() {
    print_status "Collecting initial metrics..."
    
    cd "$SCRIPTS_DIR"
    
    # Run metrics collection in background
    python3 collect_metrics.py > /dev/null 2>&1 &
    python3 health_check.py > /dev/null 2>&1 &
    
    print_success "Initial metrics collection started"
}

# Function to print dashboard info
print_dashboard_info() {
    local url=$1
    local port=$2
    
    echo ""
    echo "=============================================="
    echo "🤖 Claude Framework Dashboard"
    echo "=============================================="
    echo "📊 Dashboard URL: $url"
    echo "🔗 API Endpoints: ${url}/api/"
    echo "📁 Framework Root: $FRAMEWORK_ROOT"
    echo "🔌 Server Port: $port"
    echo "=============================================="
    echo ""
    echo "📈 Available API Endpoints:"
    echo "  • /api/health        - Framework health check"
    echo "  • /api/metrics       - Comprehensive metrics"
    echo "  • /api/agents        - Agent usage analytics"
    echo "  • /api/git-status    - Git repository status"
    echo "  • /api/operations    - Operations activity"
    echo "  • /api/navigation    - Framework navigation"
    echo "  • /api/realtime-metrics - Real-time metrics"
    echo ""
    echo "⚡ Quick Actions:"
    echo "  • Health Check: curl ${url}/api/health"
    echo "  • View Metrics: curl ${url}/api/metrics"
    echo "  • Stop Server: kill \$(cat /tmp/claude_dashboard_pid)"
    echo ""
    echo "🛑 To stop the dashboard, press Ctrl+C or close this terminal"
    echo "=============================================="
}

# Main execution
main() {
    echo "🚀 Claude Framework Dashboard Startup"
    echo "======================================"
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --port)
                DASHBOARD_PORT="$2"
                shift 2
                ;;
            --host)
                DASHBOARD_HOST="$2"
                shift 2
                ;;
            --framework-root)
                FRAMEWORK_ROOT="$2"
                SCRIPTS_DIR="${FRAMEWORK_ROOT}/system/dashboard/scripts"
                shift 2
                ;;
            --no-browser)
                NO_BROWSER=true
                shift
                ;;
            --help)
                echo "Usage: $0 [OPTIONS]"
                echo "Options:"
                echo "  --port PORT           Dashboard port (default: 8080)"
                echo "  --host HOST           Dashboard host (default: 127.0.0.1)"
                echo "  --framework-root DIR  Framework root directory"
                echo "  --no-browser          Don't open browser automatically"
                echo "  --help                Show this help message"
                exit 0
                ;;
            *)
                print_error "Unknown option: $1"
                exit 1
                ;;
        esac
    done
    
    # Check dependencies
    if ! check_dependencies; then
        print_error "Dependency check failed"
        exit 1
    fi
    
    # Stop any existing dashboard
    stop_existing
    
    # Find available port
    if ! check_port "$DASHBOARD_PORT"; then
        print_warning "Port $DASHBOARD_PORT is in use, finding alternative..."
        AVAILABLE_PORT=$(find_available_port "$DASHBOARD_PORT")
        
        if [ "$AVAILABLE_PORT" -eq -1 ]; then
            print_error "Could not find available port"
            exit 1
        fi
        
        DASHBOARD_PORT="$AVAILABLE_PORT"
        print_status "Using port: $DASHBOARD_PORT"
    fi
    
    # Update dashboard URL
    DASHBOARD_URL="http://${DASHBOARD_HOST}:${DASHBOARD_PORT}"
    
    # Collect initial metrics
    collect_metrics
    
    # Start dashboard server
    if ! start_server "$DASHBOARD_PORT"; then
        print_error "Failed to start dashboard server"
        exit 1
    fi
    
    # Print dashboard information
    print_dashboard_info "$DASHBOARD_URL" "$DASHBOARD_PORT"
    
    # Open browser (unless disabled)
    if [ "$NO_BROWSER" != "true" ]; then
        sleep 2  # Give server a moment to fully initialize
        open_browser "$DASHBOARD_URL"
    fi
    
    # Keep script running and handle Ctrl+C
    trap 'print_status "Shutting down dashboard..."; stop_existing; exit 0' INT
    
    print_status "Dashboard is running. Press Ctrl+C to stop."
    
    # Keep script alive
    while true; do
        sleep 10
        
        # Check if server is still running
        if [ -f "/tmp/claude_dashboard_pid" ]; then
            local pid=$(cat "/tmp/claude_dashboard_pid")
            if ! kill -0 $pid 2>/dev/null; then
                print_error "Dashboard server has stopped unexpectedly"
                rm -f "/tmp/claude_dashboard_pid"
                exit 1
            fi
        else
            print_error "Dashboard server PID file missing"
            exit 1
        fi
    done
}

# Run main function with all arguments
main "$@"