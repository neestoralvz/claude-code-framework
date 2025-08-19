# Multi-stage Dockerfile for Automated Ticket Dashboard
# Production-ready containerization with security best practices

# Stage 1: Build stage
FROM node:18-alpine AS builder

# Set working directory
WORKDIR /app

# Copy package files (create minimal package.json)
COPY package*.json ./

# Install dependencies
RUN npm ci --only=production

# Stage 2: Production stage
FROM node:18-alpine AS production

# Security: Create non-root user
RUN addgroup -g 1001 -S dashboard && \
    adduser -S dashboard -u 1001 -G dashboard

# Install required system packages for file watching and health monitoring
RUN apk add --no-cache \
    dumb-init \
    curl \
    && rm -rf /var/cache/apk/*

# Set working directory
WORKDIR /app

# Copy application code with proper ownership
COPY --chown=dashboard:dashboard . .

# Copy node_modules from builder stage
COPY --from=builder --chown=dashboard:dashboard /app/node_modules ./node_modules

# Create required directories with proper permissions
RUN mkdir -p \
    /app/data/ticket-state \
    /app/data/agent-sessions \
    /app/data/file-movements \
    /app/data/lifecycle-audit \
    /app/data/metrics-archive \
    /app/logs \
    /app/cache \
    /app/reports \
    /app/metrics \
    /claude-data \
    && chown -R dashboard:dashboard /app /claude-data

# Create volume mount points
VOLUME ["/claude-data", "/app/logs", "/app/data", "/app/metrics"]

# Switch to non-root user
USER dashboard

# Health check configuration
HEALTHCHECK --interval=30s --timeout=10s --start-period=5s --retries=3 \
    CMD node healthcheck.js || exit 1

# Expose port for web interface (if needed)
EXPOSE 3000

# Set environment variables
ENV NODE_ENV=production \
    DASHBOARD_PORT=3000 \
    DASHBOARD_HOST=0.0.0.0 \
    LOG_LEVEL=info

# Use dumb-init for proper signal handling
ENTRYPOINT ["/usr/bin/dumb-init", "--"]

# Start the dashboard deployment
CMD ["node", "deploy.js"]