/**
 * FILE MOVEMENT AUTOMATION SYSTEM
 * 
 * Automatic file movement between directories based on ticket status
 * with lifecycle state management and integrity validation.
 */

const fs = require('fs');
const path = require('path');

class FileMovementAutomation {
    constructor() {
        this.baseDir = '/Users/nalve/.claude';
        this.todosDir = path.join(this.baseDir, 'todos');
        this.dashboardDir = path.join(this.baseDir, 'operations/ticket-dashboard');
        this.logFile = path.join(this.dashboardDir, 'logs/file-movement.log');
        
        this.statusDirectoryMap = {
            'pending': 'pending',
            'in_progress': 'in-progress', 
            'completed': 'completed',
            'resolved': 'completed',
            'blocked': 'pending',
            'archived': 'archived'
        };
        
        this.initializeSystem();
    }
    
    initializeSystem() {
        this.ensureDirectoriesExist();
        this.setupLogging();
        console.log('📁 File Movement Automation initialized');
    }
    
    ensureDirectoriesExist() {
        Object.values(this.statusDirectoryMap).forEach(dir => {
            const fullPath = path.join(this.todosDir, dir);
            if (!fs.existsSync(fullPath)) {
                fs.mkdirSync(fullPath, { recursive: true });
            }
        });
        
        const logsDir = path.dirname(this.logFile);
        if (!fs.existsSync(logsDir)) {
            fs.mkdirSync(logsDir, { recursive: true });
        }
    }
    
    setupLogging() {
        // Initialize log file if it doesn't exist
        if (!fs.existsSync(this.logFile)) {
            fs.writeFileSync(this.logFile, '# File Movement Automation Log\n');
        }
    }
    
    log(message) {
        const timestamp = new Date().toISOString();
        const logEntry = timestamp + ' - ' + message + '\n';
        fs.appendFileSync(this.logFile, logEntry);
        console.log('📁 ' + message);
    }
    
    moveTicketFile(ticketId, fromStatus, toStatus, ticketPath = null) {
        try {
            const fromDir = this.statusDirectoryMap[fromStatus];
            const toDir = this.statusDirectoryMap[toStatus];
            
            if (!fromDir || !toDir) {
                this.log('Invalid status mapping: ' + fromStatus + ' -> ' + toStatus);
                return { success: false, error: 'Invalid status mapping' };
            }
            
            if (fromDir === toDir) {
                this.log('No move needed for ' + ticketId + ' (same directory)');
                return { success: true, message: 'No move needed' };
            }
            
            // Find the ticket file
            const ticketFile = this.findTicketFile(ticketId, fromDir, ticketPath);
            if (!ticketFile) {
                this.log('Ticket file not found: ' + ticketId + ' in ' + fromDir);
                return { success: false, error: 'Ticket file not found' };
            }
            
            // Perform the move
            const result = this.performFileMove(ticketFile, fromDir, toDir, fromStatus, toStatus);
            
            if (result.success) {
                this.log('Successfully moved ' + ticketId + ' from ' + fromDir + ' to ' + toDir);
                
                // Update audit trail
                this.updateAuditTrail(ticketId, fromStatus, toStatus, result.newPath);
            }
            
            return result;
            
        } catch (error) {
            this.log('Error moving ticket ' + ticketId + ': ' + error.message);
            return { success: false, error: error.message };
        }
    }
    
    findTicketFile(ticketId, directory, hintPath = null) {
        if (hintPath && fs.existsSync(hintPath)) {
            return hintPath;
        }
        
        const searchDir = path.join(this.todosDir, directory);
        if (!fs.existsSync(searchDir)) {
            return null;
        }
        
        const files = fs.readdirSync(searchDir);
        
        // Look for files that contain the ticket ID
        for (const file of files) {
            if (file.includes(ticketId) && file.endsWith('.md')) {
                return path.join(searchDir, file);
            }
        }
        
        return null;
    }
    
    performFileMove(sourceFile, fromDir, toDir, fromStatus, toStatus) {
        const fileName = path.basename(sourceFile);
        const targetDir = path.join(this.todosDir, toDir);
        const targetFile = path.join(targetDir, fileName);
        
        // Ensure target directory exists
        if (!fs.existsSync(targetDir)) {
            fs.mkdirSync(targetDir, { recursive: true });
        }
        
        // Check if target file already exists
        if (fs.existsSync(targetFile)) {
            this.log('Target file already exists: ' + targetFile);
            return { success: false, error: 'Target file already exists' };
        }
        
        // Read and update file content
        let content = fs.readFileSync(sourceFile, 'utf8');
        content = this.updateFileMetadata(content, toStatus);
        
        // Create backup before moving
        const backupFile = sourceFile + '.backup.' + new Date().getTime();
        fs.copyFileSync(sourceFile, backupFile);
        
        try {
            // Write to new location
            fs.writeFileSync(targetFile, content);
            
            // Verify the write was successful
            if (!fs.existsSync(targetFile)) {
                throw new Error('Failed to write target file');
            }
            
            // Remove original file
            fs.unlinkSync(sourceFile);
            
            // Clean up backup on success
            fs.unlinkSync(backupFile);
            
            return {
                success: true,
                oldPath: sourceFile,
                newPath: targetFile,
                fromDir: fromDir,
                toDir: toDir
            };
            
        } catch (error) {
            // Restore from backup on failure
            if (fs.existsSync(backupFile)) {
                fs.copyFileSync(backupFile, sourceFile);
                fs.unlinkSync(backupFile);
            }
            
            // Clean up target file if it was created
            if (fs.existsSync(targetFile)) {
                fs.unlinkSync(targetFile);
            }
            
            throw error;
        }
    }
    
    updateFileMetadata(content, newStatus) {
        const timestamp = new Date().toISOString();
        
        // Update status in frontmatter
        content = this.updateFrontmatterField(content, 'status', newStatus);
        content = this.updateFrontmatterField(content, 'updated', timestamp);
        
        // Add status transition timestamp
        const statusField = newStatus + '_at';
        content = this.updateFrontmatterField(content, statusField, timestamp);
        
        return content;
    }
    
    updateFrontmatterField(content, fieldName, value) {
        const frontmatterRegex = /^---\n([\s\S]*?)\n---/;
        const match = content.match(frontmatterRegex);
        
        if (match) {
            let frontmatter = match[1];
            const fieldRegex = new RegExp('^' + fieldName + ':.*$', 'm');
            
            if (fieldRegex.test(frontmatter)) {
                frontmatter = frontmatter.replace(fieldRegex, fieldName + ': "' + value + '"');
            } else {
                frontmatter += '\n' + fieldName + ': "' + value + '"';
            }
            
            return content.replace(frontmatterRegex, '---\n' + frontmatter + '\n---');
        } else {
            // Add frontmatter if it doesn't exist
            const newFrontmatter = '---\n' + fieldName + ': "' + value + '"\n---\n\n';
            return newFrontmatter + content;
        }
    }
    
    updateAuditTrail(ticketId, fromStatus, toStatus, newPath) {
        const auditFile = path.join(this.dashboardDir, 'data/file-movement-audit.json');
        let auditData = [];
        
        if (fs.existsSync(auditFile)) {
            try {
                auditData = JSON.parse(fs.readFileSync(auditFile, 'utf8'));
            } catch (error) {
                this.log('Error reading audit file: ' + error.message);
                auditData = [];
            }
        }
        
        auditData.push({
            ticketId: ticketId,
            fromStatus: fromStatus,
            toStatus: toStatus,
            newPath: newPath,
            timestamp: new Date().toISOString(),
            action: 'file_moved'
        });
        
        // Keep only last 1000 entries
        if (auditData.length > 1000) {
            auditData = auditData.slice(-1000);
        }
        
        const auditDir = path.dirname(auditFile);
        if (!fs.existsSync(auditDir)) {
            fs.mkdirSync(auditDir, { recursive: true });
        }
        
        fs.writeFileSync(auditFile, JSON.stringify(auditData, null, 2));
    }
    
    // Bulk file organization
    organizeAllTickets() {
        const results = {
            processed: 0,
            moved: 0,
            errors: 0,
            details: []
        };
        
        this.log('Starting bulk ticket organization...');
        
        Object.keys(this.statusDirectoryMap).forEach(status => {
            const dir = this.statusDirectoryMap[status];
            const dirPath = path.join(this.todosDir, dir);
            
            if (fs.existsSync(dirPath)) {
                const files = fs.readdirSync(dirPath).filter(f => f.endsWith('.md'));
                
                files.forEach(file => {
                    const filePath = path.join(dirPath, file);
                    const result = this.validateFileLocation(filePath, status);
                    
                    results.processed++;
                    
                    if (result.needsMove) {
                        const moveResult = this.moveTicketFile(
                            result.ticketId, 
                            status, 
                            result.correctStatus, 
                            filePath
                        );
                        
                        if (moveResult.success) {
                            results.moved++;
                        } else {
                            results.errors++;
                        }
                        
                        results.details.push({
                            file: file,
                            action: moveResult.success ? 'moved' : 'error',
                            details: moveResult
                        });
                    }
                });
            }
        });
        
        this.log('Bulk organization complete: ' + results.moved + ' moved, ' + results.errors + ' errors');
        return results;
    }
    
    validateFileLocation(filePath, directoryStatus) {
        try {
            const content = fs.readFileSync(filePath, 'utf8');
            const fileStatus = this.extractStatusFromFile(content);
            const ticketId = this.extractTicketIdFromFile(content, filePath);
            
            const expectedDir = this.statusDirectoryMap[fileStatus];
            const currentDir = this.statusDirectoryMap[directoryStatus];
            
            return {
                ticketId: ticketId,
                fileStatus: fileStatus,
                directoryStatus: directoryStatus,
                correctStatus: fileStatus,
                needsMove: expectedDir !== currentDir,
                expectedDir: expectedDir,
                currentDir: currentDir
            };
            
        } catch (error) {
            return {
                ticketId: null,
                needsMove: false,
                error: error.message
            };
        }
    }
    
    extractStatusFromFile(content) {
        const statusMatch = content.match(/^status:\s*"?([^"\n]+)"?/m);
        return statusMatch ? statusMatch[1] : 'pending';
    }
    
    extractTicketIdFromFile(content, filePath) {
        const idMatch = content.match(/^id:\s*"?([^"\n]+)"?/m);
        if (idMatch) {
            return idMatch[1];
        }
        
        // Fallback to filename
        const fileName = path.basename(filePath, '.md');
        return fileName;
    }
    
    // Public API methods
    getMovementStatistics() {
        const auditFile = path.join(this.dashboardDir, 'data/file-movement-audit.json');
        
        if (!fs.existsSync(auditFile)) {
            return {
                totalMoves: 0,
                recentMoves: [],
                statusTransitions: {}
            };
        }
        
        try {
            const auditData = JSON.parse(fs.readFileSync(auditFile, 'utf8'));
            
            const stats = {
                totalMoves: auditData.length,
                recentMoves: auditData.slice(-10),
                statusTransitions: {}
            };
            
            auditData.forEach(entry => {
                const transition = entry.fromStatus + ' -> ' + entry.toStatus;
                stats.statusTransitions[transition] = (stats.statusTransitions[transition] || 0) + 1;
            });
            
            return stats;
            
        } catch (error) {
            this.log('Error reading movement statistics: ' + error.message);
            return { error: error.message };
        }
    }
    
    validateDirectoryIntegrity() {
        const report = {
            timestamp: new Date().toISOString(),
            directories: {},
            misplacedFiles: [],
            totalFiles: 0
        };
        
        Object.keys(this.statusDirectoryMap).forEach(status => {
            const dir = this.statusDirectoryMap[status];
            const dirPath = path.join(this.todosDir, dir);
            
            report.directories[dir] = {
                status: status,
                exists: fs.existsSync(dirPath),
                fileCount: 0,
                misplacedCount: 0
            };
            
            if (fs.existsSync(dirPath)) {
                const files = fs.readdirSync(dirPath).filter(f => f.endsWith('.md'));
                report.directories[dir].fileCount = files.length;
                report.totalFiles += files.length;
                
                files.forEach(file => {
                    const filePath = path.join(dirPath, file);
                    const validation = this.validateFileLocation(filePath, status);
                    
                    if (validation.needsMove) {
                        report.directories[dir].misplacedCount++;
                        report.misplacedFiles.push({
                            file: file,
                            currentLocation: dir,
                            expectedLocation: validation.expectedDir,
                            fileStatus: validation.fileStatus,
                            ticketId: validation.ticketId
                        });
                    }
                });
            }
        });
        
        return report;
    }
}

// Export for module usage
if (typeof module !== 'undefined' && module.exports) {
    module.exports = FileMovementAutomation;
}

// CLI execution
if (require.main === module) {
    const automation = new FileMovementAutomation();
    
    const command = process.argv[2];
    
    switch (command) {
        case 'organize':
            console.log(JSON.stringify(automation.organizeAllTickets(), null, 2));
            break;
        case 'stats':
            console.log(JSON.stringify(automation.getMovementStatistics(), null, 2));
            break;
        case 'validate':
            console.log(JSON.stringify(automation.validateDirectoryIntegrity(), null, 2));
            break;
        default:
            console.log('File Movement Automation ready');
            console.log('Commands: organize, stats, validate');
    }
}
