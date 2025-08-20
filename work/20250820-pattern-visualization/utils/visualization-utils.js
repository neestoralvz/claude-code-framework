/**
 * Universal Pattern Visualization Utilities
 * Supporting functions for the pattern visualization system
 */

class PatternVisualizationUtils {
    constructor() {
        this.colorScheme = {
            primary: '#6366f1',
            success: '#10b981',
            warning: '#f59e0b',
            danger: '#ef4444',
            info: '#06b6d4',
            purple: '#8b5cf6',
            accent: '#00d4ff',
            background: '#0f172a',
            surface: '#1e293b',
            text: '#f8fafc',
            textSecondary: '#94a3b8',
            border: '#475569'
        };

        this.performanceThresholds = {
            excellent: 95,
            good: 85,
            warning: 75,
            critical: 0
        };

        this.clusterColors = {
            primary: '#6366f1',
            secondary: '#10b981',
            tertiary: '#f59e0b',
            quaternary: '#8b5cf6'
        };
    }

    /**
     * Get performance status based on value
     * @param {number} performance - Performance value (0-100)
     * @returns {string} - Status: active, partial, inactive
     */
    getPerformanceStatus(performance) {
        if (performance >= this.performanceThresholds.excellent) return 'active';
        if (performance >= this.performanceThresholds.warning) return 'partial';
        return 'inactive';
    }

    /**
     * Get performance color based on value
     * @param {number} performance - Performance value (0-100)
     * @returns {string} - Hex color code
     */
    getPerformanceColor(performance) {
        if (performance >= this.performanceThresholds.excellent) return this.colorScheme.success;
        if (performance >= this.performanceThresholds.good) return this.colorScheme.info;
        if (performance >= this.performanceThresholds.warning) return this.colorScheme.warning;
        return this.colorScheme.danger;
    }

    /**
     * Get trend icon based on trend string
     * @param {string} trend - Trend: up, down, stable
     * @returns {string} - Unicode arrow character
     */
    getTrendIcon(trend) {
        const icons = {
            up: '↗️',
            down: '↘️',
            stable: '→'
        };
        return icons[trend] || '→';
    }

    /**
     * Get cluster color
     * @param {string} clusterId - Cluster identifier
     * @returns {string} - Hex color code
     */
    getClusterColor(clusterId) {
        return this.clusterColors[clusterId] || this.colorScheme.primary;
    }

    /**
     * Calculate overall system performance
     * @param {Array} mandates - Array of mandate objects
     * @returns {number} - Overall performance percentage
     */
    calculateOverallPerformance(mandates) {
        if (!mandates || mandates.length === 0) return 0;
        
        const totalPerformance = mandates.reduce((sum, mandate) => 
            sum + mandate.performance.current, 0);
        
        return Math.round((totalPerformance / mandates.length) * 10) / 10;
    }

    /**
     * Calculate cluster average performance
     * @param {Array} mandates - Array of mandate objects for the cluster
     * @returns {number} - Cluster average performance
     */
    calculateClusterPerformance(mandates) {
        if (!mandates || mandates.length === 0) return 0;
        
        const totalPerformance = mandates.reduce((sum, mandate) => 
            sum + mandate.performance.current, 0);
        
        return Math.round((totalPerformance / mandates.length) * 10) / 10;
    }

    /**
     * Count active mandates
     * @param {Array} mandates - Array of mandate objects
     * @returns {number} - Number of active mandates
     */
    countActiveMandates(mandates) {
        if (!mandates) return 0;
        return mandates.filter(mandate => mandate.status === 'active').length;
    }

    /**
     * Generate gradient CSS based on performance
     * @param {number} performance - Performance value (0-100)
     * @returns {string} - CSS gradient string
     */
    generatePerformanceGradient(performance) {
        const color = this.getPerformanceColor(performance);
        const opacity = Math.max(0.1, performance / 100);
        return `linear-gradient(135deg, ${color}${Math.round(opacity * 255).toString(16)}, transparent)`;
    }

    /**
     * Format timestamp for display
     * @param {string} timestamp - ISO timestamp string
     * @returns {string} - Formatted time string
     */
    formatTimestamp(timestamp) {
        if (!timestamp) return '--:--:--';
        const date = new Date(timestamp);
        return date.toLocaleTimeString();
    }

    /**
     * Format timestamp for display (full)
     * @param {string} timestamp - ISO timestamp string
     * @returns {string} - Formatted date and time string
     */
    formatFullTimestamp(timestamp) {
        if (!timestamp) return 'Unknown';
        const date = new Date(timestamp);
        return date.toLocaleString();
    }

    /**
     * Generate unique ID
     * @param {string} prefix - ID prefix
     * @returns {string} - Unique ID
     */
    generateId(prefix = 'id') {
        return `${prefix}-${Date.now()}-${Math.random().toString(36).substr(2, 9)}`;
    }

    /**
     * Debounce function calls
     * @param {Function} func - Function to debounce
     * @param {number} wait - Wait time in milliseconds
     * @returns {Function} - Debounced function
     */
    debounce(func, wait) {
        let timeout;
        return function executedFunction(...args) {
            const later = () => {
                clearTimeout(timeout);
                func(...args);
            };
            clearTimeout(timeout);
            timeout = setTimeout(later, wait);
        };
    }

    /**
     * Throttle function calls
     * @param {Function} func - Function to throttle
     * @param {number} limit - Time limit in milliseconds
     * @returns {Function} - Throttled function
     */
    throttle(func, limit) {
        let inThrottle;
        return function(...args) {
            if (!inThrottle) {
                func.apply(this, args);
                inThrottle = true;
                setTimeout(() => inThrottle = false, limit);
            }
        };
    }

    /**
     * Animate number changes
     * @param {HTMLElement} element - Element to animate
     * @param {number} from - Starting number
     * @param {number} to - Ending number
     * @param {number} duration - Animation duration in ms
     * @param {string} suffix - Number suffix (%, etc.)
     */
    animateNumber(element, from, to, duration = 1000, suffix = '') {
        const startTime = performance.now();
        const difference = to - from;

        const animate = (currentTime) => {
            const elapsed = currentTime - startTime;
            const progress = Math.min(elapsed / duration, 1);
            
            // Easing function (ease-out)
            const easeOut = 1 - Math.pow(1 - progress, 3);
            const current = from + (difference * easeOut);
            
            element.textContent = Math.round(current * 10) / 10 + suffix;
            
            if (progress < 1) {
                requestAnimationFrame(animate);
            }
        };

        requestAnimationFrame(animate);
    }

    /**
     * Create sparkline SVG
     * @param {Array} data - Array of numbers
     * @param {number} width - SVG width
     * @param {number} height - SVG height
     * @param {string} color - Line color
     * @returns {string} - SVG string
     */
    createSparkline(data, width = 100, height = 30, color = '#00d4ff') {
        if (!data || data.length < 2) return '';

        const min = Math.min(...data);
        const max = Math.max(...data);
        const range = max - min || 1;

        const points = data.map((value, index) => {
            const x = (index / (data.length - 1)) * width;
            const y = height - ((value - min) / range) * height;
            return `${x},${y}`;
        }).join(' ');

        return `
            <svg width="${width}" height="${height}" viewBox="0 0 ${width} ${height}">
                <polyline
                    fill="none"
                    stroke="${color}"
                    stroke-width="2"
                    points="${points}"
                />
            </svg>
        `;
    }

    /**
     * Create progress ring SVG
     * @param {number} percentage - Progress percentage (0-100)
     * @param {number} size - Ring size in pixels
     * @param {string} color - Ring color
     * @param {number} strokeWidth - Stroke width
     * @returns {string} - SVG string
     */
    createProgressRing(percentage, size = 60, color = '#00d4ff', strokeWidth = 4) {
        const radius = (size - strokeWidth) / 2;
        const circumference = radius * 2 * Math.PI;
        const strokeDasharray = `${circumference} ${circumference}`;
        const strokeDashoffset = circumference - (percentage / 100) * circumference;

        return `
            <svg width="${size}" height="${size}" class="progress-ring">
                <circle
                    stroke="#334155"
                    stroke-width="${strokeWidth}"
                    fill="transparent"
                    r="${radius}"
                    cx="${size / 2}"
                    cy="${size / 2}"
                />
                <circle
                    stroke="${color}"
                    stroke-width="${strokeWidth}"
                    stroke-linecap="round"
                    stroke-dasharray="${strokeDasharray}"
                    stroke-dashoffset="${strokeDashoffset}"
                    fill="transparent"
                    r="${radius}"
                    cx="${size / 2}"
                    cy="${size / 2}"
                    style="transition: stroke-dashoffset 0.5s ease-in-out;"
                />
            </svg>
        `;
    }

    /**
     * Export visualization as image
     * @param {HTMLElement} element - Element to export
     * @param {string} filename - Export filename
     * @param {string} format - Export format (png, svg, pdf)
     */
    async exportAsImage(element, filename, format = 'png') {
        try {
            if (format === 'svg') {
                this.exportAsSVG(element, filename);
                return;
            }

            // For PNG/PDF, we need to use canvas
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d');
            const rect = element.getBoundingClientRect();
            
            canvas.width = rect.width * 2; // Higher resolution
            canvas.height = rect.height * 2;
            ctx.scale(2, 2);

            // Create SVG with HTML content
            const svgData = `
                <svg xmlns="http://www.w3.org/2000/svg" width="${rect.width}" height="${rect.height}">
                    <foreignObject width="100%" height="100%">
                        <div xmlns="http://www.w3.org/1999/xhtml">
                            ${element.outerHTML}
                        </div>
                    </foreignObject>
                </svg>
            `;

            const img = new Image();
            const blob = new Blob([svgData], { type: 'image/svg+xml' });
            const url = URL.createObjectURL(blob);

            img.onload = () => {
                ctx.drawImage(img, 0, 0);
                URL.revokeObjectURL(url);
                
                canvas.toBlob((blob) => {
                    this.downloadBlob(blob, filename, 'image/png');
                }, 'image/png');
            };

            img.src = url;
        } catch (error) {
            console.error('Export failed:', error);
            throw new Error(`Export failed: ${error.message}`);
        }
    }

    /**
     * Export as SVG
     * @param {HTMLElement} element - Element to export
     * @param {string} filename - Export filename
     */
    exportAsSVG(element, filename) {
        const rect = element.getBoundingClientRect();
        const svgData = `
            <svg xmlns="http://www.w3.org/2000/svg" width="${rect.width}" height="${rect.height}">
                <foreignObject width="100%" height="100%">
                    <div xmlns="http://www.w3.org/1999/xhtml">
                        ${element.outerHTML}
                    </div>
                </foreignObject>
            </svg>
        `;

        const blob = new Blob([svgData], { type: 'image/svg+xml' });
        this.downloadBlob(blob, filename, 'image/svg+xml');
    }

    /**
     * Export data as JSON
     * @param {Object} data - Data to export
     * @param {string} filename - Export filename
     */
    exportAsJSON(data, filename) {
        const jsonData = JSON.stringify(data, null, 2);
        const blob = new Blob([jsonData], { type: 'application/json' });
        this.downloadBlob(blob, filename, 'application/json');
    }

    /**
     * Download blob as file
     * @param {Blob} blob - Blob to download
     * @param {string} filename - Download filename
     * @param {string} mimeType - MIME type
     */
    downloadBlob(blob, filename, mimeType) {
        const url = URL.createObjectURL(blob);
        const link = document.createElement('a');
        link.href = url;
        link.download = filename;
        link.style.display = 'none';
        
        document.body.appendChild(link);
        link.click();
        document.body.removeChild(link);
        
        URL.revokeObjectURL(url);
    }

    /**
     * Validate data against schema
     * @param {Object} data - Data to validate
     * @param {Object} schema - JSON schema
     * @returns {Object} - Validation result
     */
    validateData(data, schema) {
        // Basic validation - in production, use a proper JSON schema validator
        const result = {
            valid: true,
            errors: []
        };

        try {
            // Check required properties
            if (schema.required) {
                for (const prop of schema.required) {
                    if (!(prop in data)) {
                        result.valid = false;
                        result.errors.push(`Missing required property: ${prop}`);
                    }
                }
            }

            // Check universal execution mandates
            if (data.universalExecutionMandates) {
                if (data.universalExecutionMandates.length !== 16) {
                    result.valid = false;
                    result.errors.push('Universal Execution Mandates must contain exactly 16 items');
                }
            }

            // Check pattern clusters
            if (data.patternClusters) {
                if (data.patternClusters.length !== 4) {
                    result.valid = false;
                    result.errors.push('Pattern Clusters must contain exactly 4 items');
                }
            }
        } catch (error) {
            result.valid = false;
            result.errors.push(`Validation error: ${error.message}`);
        }

        return result;
    }

    /**
     * Generate mock real-time data
     * @param {Object} baseData - Base data to modify
     * @returns {Object} - Updated data with simulated changes
     */
    generateMockRealTimeData(baseData) {
        const updatedData = JSON.parse(JSON.stringify(baseData)); // Deep clone

        // Update mandate performances with small random changes
        updatedData.universalExecutionMandates.forEach(mandate => {
            const currentPerf = mandate.performance.current;
            const change = (Math.random() - 0.5) * 2; // ±1%
            mandate.performance.current = Math.max(70, Math.min(100, currentPerf + change));
            
            // Update trend based on change
            if (change > 0.5) mandate.performance.trend = 'up';
            else if (change < -0.5) mandate.performance.trend = 'down';
            else mandate.performance.trend = 'stable';

            // Update status based on performance
            mandate.status = this.getPerformanceStatus(mandate.performance.current);
        });

        // Update system metrics
        updatedData.systemMetrics.overallPerformance = this.calculateOverallPerformance(updatedData.universalExecutionMandates);
        updatedData.systemMetrics.activeMandateCount = this.countActiveMandates(updatedData.universalExecutionMandates);
        updatedData.systemMetrics.lastUpdated = new Date().toISOString();

        // Update real-time metrics
        updatedData.realTimeMetrics.activeNodes = 15 + Math.floor(Math.random() * 2);
        updatedData.realTimeMetrics.connections = 60 + Math.floor(Math.random() * 8);
        updatedData.realTimeMetrics.flowRate = 2000 + Math.floor(Math.random() * 800);

        return updatedData;
    }

    /**
     * Calculate system health score
     * @param {Object} data - System data
     * @returns {number} - Health score (0-100)
     */
    calculateSystemHealth(data) {
        if (!data) return 0;

        const weights = {
            overallPerformance: 0.4,
            systemCoherence: 0.3,
            integrationEfficiency: 0.2,
            optimizationIndex: 0.1
        };

        let healthScore = 0;
        healthScore += (data.systemMetrics?.overallPerformance || 0) * weights.overallPerformance;
        healthScore += (data.systemMetrics?.systemCoherence || 0) * weights.systemCoherence;
        healthScore += (data.systemMetrics?.integrationEfficiency || 0) * weights.integrationEfficiency;
        healthScore += (data.systemMetrics?.optimizationIndex || 0) * weights.optimizationIndex;

        return Math.round(healthScore * 10) / 10;
    }
}

// Export for use in other modules
if (typeof module !== 'undefined' && module.exports) {
    module.exports = PatternVisualizationUtils;
} else if (typeof window !== 'undefined') {
    window.PatternVisualizationUtils = PatternVisualizationUtils;
}