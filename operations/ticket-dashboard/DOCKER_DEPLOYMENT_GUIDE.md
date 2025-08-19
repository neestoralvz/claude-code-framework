# Docker Deployment Guide
## Automated Ticket Dashboard - Containerized Solution

## Overview

This comprehensive Docker containerization solution provides a production-ready deployment of the automated ticket dashboard with intelligent port management, data persistence, and seamless Claude integration.

## 🚀 Quick Start

### 1. One-Command Deployment
```bash
cd /Users/nalve/.claude/operations/ticket-dashboard
./docker-deploy.sh
```

### 2. Manual Docker Compose
```bash
docker-compose up -d
```

### 3. Development Mode
```bash
# Use override configuration for development
docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

## 📋 Prerequisites

- Docker Engine 20.10+ installed and running
- Docker Compose 2.0+ available
- At least 2GB free disk space
- Ports 3000-3004 availability (automatic conflict detection)

## 🏗️ Architecture Components

### Core Services

| Service | Purpose | Port | Health Check |
|---------|---------|------|--------------|
| `ticket-dashboard` | Main dashboard application | 3000 | `/health` |
| `port-manager` | Intelligent port conflict detection | - | Init only |
| `backup-service` | Automated data backup | - | Cron-based |
| `monitoring` | Service health monitoring | - | Continuous |

### Volume Mappings

| Volume | Purpose | Host Path | Container Path |
|--------|---------|-----------|----------------|
| `claude-data` | Claude system integration | `/Users/nalve/.claude` | `/claude-data` |
| `dashboard-data` | Dashboard persistent data | `./docker-volumes/data` | `/app/data` |
| `dashboard-logs` | Application logs | `./docker-volumes/logs` | `/app/logs` |
| `dashboard-metrics` | Performance metrics | `./docker-volumes/metrics` | `/app/metrics` |
| `dashboard-backups` | Automated backups | `./docker-volumes/backups` | `/backups` |

## 🔧 Configuration

### Environment Variables

#### Core Settings
```bash
DASHBOARD_PORT=3000                    # Main dashboard port
DASHBOARD_ADMIN_PORT=3001             # Admin/WebSocket port
CLAUDE_DATA_DIR=/Users/nalve/.claude  # Host Claude directory
LOG_LEVEL=info                        # Logging verbosity
```

#### Performance Settings
```bash
REFRESH_INTERVAL=5000                 # Dashboard refresh (ms)
AUTO_SYNC_ENABLED=true               # Enable real-time sync
BACKUP_SCHEDULE="0 2 * * *"          # Daily backup at 2 AM
BACKUP_RETENTION_DAYS=30             # Backup retention period
```

#### Monitoring Settings
```bash
HEALTH_CHECK_ENABLED=true            # Enable health monitoring
MONITOR_INTERVAL=60                  # Monitoring interval (s)
ALERT_THRESHOLD_CPU=80               # CPU usage alert threshold
ALERT_THRESHOLD_MEMORY=80            # Memory usage alert threshold
```

### Port Management

The system automatically detects and resolves port conflicts:

1. **Automatic Detection**: Scans ports 3000-3004 for availability
2. **Dynamic Assignment**: Selects first available port
3. **Environment Update**: Updates `.env` file with selected port
4. **Conflict Resolution**: Graceful fallback to default if all ports busy

## 🗂️ Data Persistence Strategy

### Host Integration
- **Claude Data Mount**: Full read/write access to `/Users/nalve/.claude`
- **Real-time Sync**: Automatic synchronization with host ticket system
- **File Watching**: Monitors ticket changes in real-time
- **Registry Integration**: Live updates to ticket registry

### Container Data
- **Persistent Volumes**: All application data persists across restarts
- **Backup System**: Automated daily backups with retention policy
- **Data Integrity**: Continuous validation and error recovery
- **Migration Support**: Easy data migration between environments

## 📊 Health Monitoring

### Health Check System

The containerized dashboard includes comprehensive health monitoring:

```javascript
// Health check endpoints
GET /health                    // Overall system health
GET /api/status               // Dashboard status
GET /api/metrics              // Performance metrics
GET /api/logs/:type           // Application logs
```

### Health Check Components

1. **File System Access**: Verify directory permissions and accessibility
2. **Dashboard Engine**: Monitor main application process
3. **Data Integrity**: Validate critical data files
4. **Registry Access**: Ensure Claude registry connectivity
5. **Performance Metrics**: Track memory and CPU usage
6. **Claude Data Mount**: Verify host directory mounting
7. **Backup System**: Monitor backup functionality

### Automated Monitoring

- **Health Checks**: Every 30 seconds
- **Performance Metrics**: Every 60 seconds
- **Log Rotation**: Automatic cleanup and archival
- **Alert Thresholds**: Configurable CPU and memory alerts

## 🌐 Web Interface

### Dashboard UI

Access the web-based dashboard at: `http://localhost:3000`

Features:
- **Real-time Status**: Live ticket status updates
- **Performance Metrics**: System resource monitoring
- **Health Overview**: Component status dashboard
- **Action Controls**: Force sync, restart, log viewing
- **WebSocket Updates**: Real-time data streaming

### API Endpoints

```bash
# Status and health
GET  /health                   # Health check
GET  /api/status              # Dashboard status
GET  /api/config              # Configuration

# Data access
GET  /api/tickets             # All ticket data
GET  /api/metrics             # Performance metrics
GET  /api/logs/:type          # Application logs

# Actions
POST /api/sync                # Trigger force sync
```

## 🔄 Integration Features

### Seamless Claude Integration

1. **Data Mount**: Direct access to Claude directory structure
2. **Real-time Sync**: Automatic synchronization with ticket changes
3. **Registry Updates**: Live registry modifications
4. **File Movement**: Automatic ticket organization
5. **Audit Trail**: Complete change history tracking

### Integration Components

- **Docker Integration Script**: Handles host-container communication
- **File Watchers**: Monitor Claude directory changes
- **Sync Engine**: Bidirectional data synchronization
- **Integrity Validation**: Continuous data verification

## 🛠️ Deployment Commands

### Primary Commands

```bash
# Full deployment
./docker-deploy.sh deploy

# Service management
./docker-deploy.sh start      # Start services
./docker-deploy.sh stop       # Stop services
./docker-deploy.sh restart    # Restart services
./docker-deploy.sh status     # Show status

# Monitoring
./docker-deploy.sh logs       # View logs
./docker-deploy.sh health     # Health check

# Maintenance
./docker-deploy.sh clean      # Full cleanup
```

### Docker Compose Commands

```bash
# Service management
docker-compose up -d          # Start in background
docker-compose down           # Stop and remove
docker-compose restart        # Restart services
docker-compose ps             # Show status

# Logs and monitoring
docker-compose logs -f        # Follow logs
docker-compose logs ticket-dashboard  # Service-specific logs

# Development
docker-compose -f docker-compose.yml -f docker-compose.override.yml up -d
```

### Container Commands

```bash
# Execute commands inside container
docker exec ticket-dashboard-app node healthcheck.js
docker exec ticket-dashboard-app cat /app/data/health-check.json
docker exec -it ticket-dashboard-app sh

# Access specific services
docker exec backup-service ls -la /backups
docker exec monitoring curl -s http://ticket-dashboard:3000/health
```

## 🔍 Troubleshooting

### Common Issues

#### Port Conflicts
```bash
# Check port usage
netstat -tuln | grep :3000

# Force port selection
DASHBOARD_PORT=3005 ./docker-deploy.sh
```

#### Mount Issues
```bash
# Verify Claude directory access
ls -la /Users/nalve/.claude

# Check container mounts
docker inspect ticket-dashboard-app | grep -A 20 "Mounts"
```

#### Data Synchronization
```bash
# Check sync status
docker exec ticket-dashboard-app cat /app/cache/last-sync.json

# Force sync
docker exec ticket-dashboard-app node docker-integration.js
```

#### Health Check Failures
```bash
# Run manual health check
docker exec ticket-dashboard-app node healthcheck.js

# Check health logs
docker exec ticket-dashboard-app cat /app/data/health-check.json
```

### Debugging Tools

#### Debug Shell
```bash
# Start debug container
docker-compose up debug-shell

# Access debug environment
docker exec -it ticket-dashboard-debug sh
```

#### Log Analysis
```bash
# Application logs
docker-compose logs ticket-dashboard

# System logs
docker logs ticket-dashboard-app

# Specific log types
docker exec ticket-dashboard-app cat /app/logs/deployment.log
```

#### Performance Analysis
```bash
# Container stats
docker stats ticket-dashboard-app

# Resource usage
docker exec ticket-dashboard-app cat /app/metrics/current.json

# Memory analysis
docker exec ticket-dashboard-app node -e "console.log(process.memoryUsage())"
```

## 🔒 Security Features

### Container Security

1. **Non-root User**: Application runs as unprivileged user
2. **Minimal Base Image**: Alpine Linux for reduced attack surface
3. **Read-only Filesystems**: Most volumes mounted as read-only where possible
4. **Network Isolation**: Custom bridge network for service communication
5. **Resource Limits**: CPU and memory constraints

### Data Security

1. **Volume Encryption**: Support for encrypted volume backends
2. **Backup Encryption**: Compressed and secured backup files
3. **Access Control**: Proper file permissions and ownership
4. **Audit Logging**: Complete access and modification tracking

## 📈 Performance Optimization

### Resource Configuration

```yaml
# Production resource limits
resources:
  limits:
    memory: 512M
    cpus: '0.5'
  reservations:
    memory: 256M
    cpus: '0.25'
```

### Optimization Features

1. **Multi-stage Builds**: Minimal production images
2. **Layer Caching**: Optimized Docker layer structure
3. **Compression**: Efficient log and backup compression
4. **Monitoring**: Real-time performance tracking

## 🔄 Backup and Recovery

### Automated Backups

- **Schedule**: Daily backups at 2 AM (configurable)
- **Retention**: 30-day retention policy (configurable)
- **Compression**: Gzip compression for space efficiency
- **Verification**: Automatic backup integrity checks

### Manual Backup

```bash
# Create manual backup
docker exec backup-service /backup.sh

# List backups
docker exec backup-service ls -la /backups

# Restore from backup
docker cp backup-service:/backups/dashboard_backup_20240819_020000.tar.gz ./
tar -xzf dashboard_backup_20240819_020000.tar.gz -C ./restore-data/
```

## 🚀 Scaling and High Availability

### Horizontal Scaling

```yaml
# Scale dashboard instances
docker-compose up -d --scale ticket-dashboard=3
```

### Load Balancing

```yaml
# Add load balancer service
load-balancer:
  image: nginx:alpine
  ports:
    - "80:80"
  volumes:
    - ./nginx.conf:/etc/nginx/nginx.conf
```

### High Availability Features

1. **Health Monitoring**: Automatic service restart on failure
2. **Data Replication**: Multi-volume backup strategy
3. **Graceful Shutdown**: Proper signal handling
4. **Rolling Updates**: Zero-downtime deployment support

## 📝 Maintenance

### Regular Maintenance Tasks

```bash
# Weekly maintenance
./docker-deploy.sh health      # Check system health
docker system prune -f         # Clean unused resources
docker volume prune -f         # Clean unused volumes

# Monthly maintenance
docker image prune -a -f       # Clean unused images
./docker-deploy.sh clean       # Full system cleanup
./docker-deploy.sh deploy      # Fresh deployment
```

### Update Procedures

```bash
# Update application
git pull origin main
./docker-deploy.sh restart

# Update base images
docker-compose pull
docker-compose up -d
```

## 📊 Success Metrics

### Deployment Verification

✅ **Port Management**: Automatic conflict detection and resolution  
✅ **Data Persistence**: All ticket data maintained across restarts  
✅ **Claude Integration**: Real-time synchronization with host system  
✅ **Health Monitoring**: Comprehensive system health tracking  
✅ **Web Interface**: Accessible dashboard with real-time updates  
✅ **Backup System**: Automated data protection and recovery  
✅ **Security**: Non-root execution with proper isolation  
✅ **Performance**: Optimized resource usage and monitoring  

### Operational Benefits

- **Zero Manual Port Configuration**: Intelligent port management
- **Seamless Integration**: Native Claude system connectivity
- **Production Ready**: Full monitoring, logging, and backup systems
- **Easy Maintenance**: Simple commands for all operations
- **Scalable Architecture**: Ready for horizontal scaling

---

**Deployment Status**: ✅ PRODUCTION READY  
**Last Updated**: 2025-08-19  
**Version**: 1.0.0