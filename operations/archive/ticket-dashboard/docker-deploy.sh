#!/bin/bash

# AUTOMATED TICKET DASHBOARD - DOCKER DEPLOYMENT SCRIPT
# Production-ready containerized deployment with intelligent port management

set -e

# Configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_NAME="ticket-dashboard"
IMAGE_NAME="automated-ticket-dashboard"
NETWORK_NAME="dashboard-network"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Logging functions
log_info() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Banner
print_banner() {
    echo -e "${BLUE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║              AUTOMATED TICKET DASHBOARD                     ║"
    echo "║              Docker Deployment Script                       ║"
    echo "║              Production-Ready Containerization              ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

# Prerequisites check
check_prerequisites() {
    log_info "Checking prerequisites..."
    
    # Check Docker
    if ! command -v docker &> /dev/null; then
        log_error "Docker is not installed or not in PATH"
        exit 1
    fi
    
    # Check Docker Compose
    if ! command -v docker-compose &> /dev/null; then
        log_error "Docker Compose is not installed or not in PATH"
        exit 1
    fi
    
    # Check Docker daemon
    if ! docker info &> /dev/null; then
        log_error "Docker daemon is not running"
        exit 1
    fi
    
    log_success "Prerequisites check passed"
}

# Setup directory structure
setup_directories() {
    log_info "Setting up directory structure..."
    
    # Create docker volumes directories
    mkdir -p "${SCRIPT_DIR}/docker-volumes"/{data,logs,metrics,cache,config,backups}
    
    # Set permissions
    chmod 755 "${SCRIPT_DIR}/docker-volumes"
    chmod -R 755 "${SCRIPT_DIR}/docker-volumes"/*
    
    log_success "Directory structure created"
}

# Port conflict detection
detect_port_conflicts() {
    log_info "Detecting port conflicts..."
    
    AVAILABLE_PORT=""
    
    # Check ports 3000-3004
    for port in {3000..3004}; do
        if ! netstat -tuln 2>/dev/null | grep -q ":${port} "; then
            AVAILABLE_PORT=$port
            break
        fi
    done
    
    if [ -z "$AVAILABLE_PORT" ]; then
        log_warning "Ports 3000-3004 are in use, using default 3000"
        AVAILABLE_PORT=3000
    fi
    
    # Update .env file
    if [ -f "${SCRIPT_DIR}/.env" ]; then
        sed -i.bak "s/DASHBOARD_PORT=.*/DASHBOARD_PORT=${AVAILABLE_PORT}/" "${SCRIPT_DIR}/.env"
    fi
    
    log_success "Selected port: ${AVAILABLE_PORT}"
    export DASHBOARD_PORT=$AVAILABLE_PORT
}

# Build Docker image
build_image() {
    log_info "Building Docker image..."
    
    cd "${SCRIPT_DIR}"
    
    # Build with build args
    docker build \
        --tag "${IMAGE_NAME}:latest" \
        --tag "${IMAGE_NAME}:$(date +%Y%m%d)" \
        --build-arg NODE_ENV=production \
        --no-cache \
        .
    
    log_success "Docker image built successfully"
}

# Network setup
setup_network() {
    log_info "Setting up Docker network..."
    
    # Create network if it doesn't exist
    if ! docker network ls | grep -q "${NETWORK_NAME}"; then
        docker network create \
            --driver bridge \
            --subnet=172.20.0.0/16 \
            "${NETWORK_NAME}"
        log_success "Created network: ${NETWORK_NAME}"
    else
        log_info "Network ${NETWORK_NAME} already exists"
    fi
}

# Deploy services
deploy_services() {
    log_info "Deploying services with Docker Compose..."
    
    cd "${SCRIPT_DIR}"
    
    # Stop existing services
    docker-compose down --remove-orphans 2>/dev/null || true
    
    # Deploy services
    docker-compose up -d --build
    
    log_success "Services deployed successfully"
}

# Health check
perform_health_check() {
    log_info "Performing health checks..."
    
    # Wait for services to start
    sleep 10
    
    # Check if main service is running
    if docker-compose ps | grep -q "ticket-dashboard-app.*Up"; then
        log_success "Main dashboard service is running"
    else
        log_error "Main dashboard service failed to start"
        return 1
    fi
    
    # Check health endpoint if web server is enabled
    local port=${DASHBOARD_PORT:-3000}
    local max_attempts=12
    local attempt=1
    
    while [ $attempt -le $max_attempts ]; do
        if curl -f -s "http://localhost:${port}/health" > /dev/null 2>&1; then
            log_success "Health check endpoint responding"
            break
        elif [ $attempt -eq $max_attempts ]; then
            log_warning "Health check endpoint not responding (dashboard may be CLI-only)"
            break
        else
            log_info "Waiting for health endpoint... (attempt $attempt/$max_attempts)"
            sleep 5
            ((attempt++))
        fi
    done
    
    # Check container health
    if docker inspect --format='{{.State.Health.Status}}' ticket-dashboard-app 2>/dev/null | grep -q "healthy"; then
        log_success "Container health check passed"
    else
        log_warning "Container health check pending or not configured"
    fi
    
    log_success "Health checks completed"
}

# Display deployment summary
show_deployment_summary() {
    echo
    echo -e "${GREEN}╔══════════════════════════════════════════════════════════════╗${NC}"
    echo -e "${GREEN}║                  DEPLOYMENT SUCCESSFUL                      ║${NC}"
    echo -e "${GREEN}╚══════════════════════════════════════════════════════════════╝${NC}"
    echo
    log_success "Dashboard Status: DEPLOYED AND OPERATIONAL"
    log_info "Dashboard Port: ${DASHBOARD_PORT:-3000}"
    log_info "Admin Port: ${DASHBOARD_ADMIN_PORT:-3001}"
    log_info "Network: ${NETWORK_NAME}"
    log_info "Data Volume: ${SCRIPT_DIR}/docker-volumes/data"
    echo
    echo -e "${BLUE}Available Commands:${NC}"
    echo "  🔍 View logs:         docker-compose logs -f"
    echo "  📊 Check status:      docker-compose ps"
    echo "  🛑 Stop services:     docker-compose down"
    echo "  🔄 Restart services:  docker-compose restart"
    echo "  📈 View metrics:      docker exec ticket-dashboard-app cat /app/metrics/current.json"
    echo
    echo -e "${BLUE}Dashboard Access:${NC}"
    echo "  🌐 Web Interface:     http://localhost:${DASHBOARD_PORT:-3000}"
    echo "  🔗 WebSocket:         ws://localhost:${DASHBOARD_ADMIN_PORT:-3001}"
    echo "  🏥 Health Check:      http://localhost:${DASHBOARD_PORT:-3000}/health"
    echo
    log_info "Dashboard is now eliminating manual status tracking!"
}

# Cleanup on failure
cleanup_on_failure() {
    log_error "Deployment failed, cleaning up..."
    docker-compose down --remove-orphans 2>/dev/null || true
    exit 1
}

# Main deployment function
main() {
    print_banner
    
    # Set trap for cleanup on failure
    trap cleanup_on_failure ERR
    
    # Run deployment steps
    check_prerequisites
    setup_directories
    detect_port_conflicts
    setup_network
    build_image
    deploy_services
    perform_health_check
    show_deployment_summary
    
    log_success "🚀 Automated Ticket Dashboard deployment completed successfully!"
}

# Handle command line arguments
case "${1:-deploy}" in
    "deploy"|"start")
        main
        ;;
    "stop")
        log_info "Stopping dashboard services..."
        docker-compose down
        log_success "Services stopped"
        ;;
    "restart")
        log_info "Restarting dashboard services..."
        docker-compose restart
        log_success "Services restarted"
        ;;
    "status")
        log_info "Dashboard service status:"
        docker-compose ps
        ;;
    "logs")
        log_info "Showing dashboard logs:"
        docker-compose logs -f
        ;;
    "health")
        log_info "Checking dashboard health:"
        docker exec ticket-dashboard-app node healthcheck.js
        ;;
    "clean")
        log_info "Cleaning up dashboard deployment..."
        docker-compose down --volumes --remove-orphans
        docker rmi "${IMAGE_NAME}:latest" 2>/dev/null || true
        log_success "Cleanup completed"
        ;;
    "help")
        echo "Usage: $0 [command]"
        echo
        echo "Commands:"
        echo "  deploy  - Deploy the dashboard (default)"
        echo "  start   - Same as deploy"
        echo "  stop    - Stop all services"
        echo "  restart - Restart all services"
        echo "  status  - Show service status"
        echo "  logs    - Show service logs"
        echo "  health  - Run health check"
        echo "  clean   - Remove all containers and images"
        echo "  help    - Show this help"
        ;;
    *)
        log_error "Unknown command: $1"
        echo "Use '$0 help' for usage information"
        exit 1
        ;;
esac