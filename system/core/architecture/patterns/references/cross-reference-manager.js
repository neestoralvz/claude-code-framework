#!/usr/bin/env node

/**
 * Cross-Reference Management System
 * Automated pattern cross-reference integrity management and validation
 * 
 * Part of the SSOT Pattern Modularization System
 * Addresses 78% cross-reference duplication elimination
 */

const fs = require('fs');
const path = require('path');
const crypto = require('crypto');

class CrossReferenceManager {
    constructor(registryPath, patternsBasePath) {
        this.registryPath = registryPath;
        this.patternsBasePath = patternsBasePath;
        this.registry = this.loadRegistry();
        this.crossReferenceCache = new Map();
        this.validationResults = new Map();
    }

    /**
     * Load pattern registry from JSON file
     */
    loadRegistry() {
        try {
            const registryData = fs.readFileSync(this.registryPath, 'utf8');
            return JSON.parse(registryData);
        } catch (error) {
            throw new Error(`Failed to load pattern registry: ${error.message}`);
        }
    }

    /**
     * Update registry with new cross-reference data
     */
    updateRegistry() {
        try {
            const registryData = JSON.stringify(this.registry, null, 2);
            fs.writeFileSync(this.registryPath, registryData, 'utf8');
            console.log('✅ Pattern registry updated successfully');
        } catch (error) {
            throw new Error(`Failed to update pattern registry: ${error.message}`);
        }
    }

    /**
     * Scan all architecture files for cross-references
     */
    async scanCrossReferences(architectureBasePath) {
        const crossReferenceMap = new Map();
        
        try {
            await this.scanDirectoryRecursive(architectureBasePath, crossReferenceMap);
            
            // Update registry with found cross-references
            this.registry.cross_reference_registry.discovered_references = 
                Object.fromEntries(crossReferenceMap);
            
            console.log(`📊 Discovered ${crossReferenceMap.size} cross-reference relationships`);
            return crossReferenceMap;
        } catch (error) {
            console.error(`❌ Cross-reference scan failed: ${error.message}`);
            throw error;
        }
    }

    /**
     * Recursively scan directory for markdown files and extract cross-references
     */
    async scanDirectoryRecursive(dirPath, referenceMap) {
        const items = fs.readdirSync(dirPath, { withFileTypes: true });
        
        for (const item of items) {
            const itemPath = path.join(dirPath, item.name);
            
            if (item.isDirectory()) {
                await this.scanDirectoryRecursive(itemPath, referenceMap);
            } else if (item.isFile() && path.extname(item.name) === '.md') {
                const references = await this.extractReferencesFromFile(itemPath);
                if (references.length > 0) {
                    referenceMap.set(itemPath, references);
                }
            }
        }
    }

    /**
     * Extract cross-references from a markdown file
     */
    async extractReferencesFromFile(filePath) {
        try {
            const content = fs.readFileSync(filePath, 'utf8');
            const references = [];
            
            // Extract markdown links: [text](path)
            const linkRegex = /\[([^\]]+)\]\(([^)]+)\)/g;
            let match;
            
            while ((match = linkRegex.exec(content)) !== null) {
                const linkText = match[1];
                const linkPath = match[2];
                
                // Skip external URLs
                if (!linkPath.startsWith('http') && !linkPath.startsWith('mailto:')) {
                    references.push({
                        text: linkText,
                        path: linkPath,
                        type: this.classifyReferenceType(linkText, linkPath),
                        line: this.getLineNumber(content, match.index),
                        context: this.extractContext(content, match.index)
                    });
                }
            }
            
            return references;
        } catch (error) {
            console.warn(`⚠️  Failed to extract references from ${filePath}: ${error.message}`);
            return [];
        }
    }

    /**
     * Classify reference type based on text and path patterns
     */
    classifyReferenceType(linkText, linkPath) {
        // Authority references
        if (linkText.includes('Authority') || linkText.includes('Principle') || linkText.includes('Directive')) {
            return 'authority';
        }
        
        // Hub navigation
        if (linkText.includes('Hub') || linkPath.includes('index.md')) {
            return 'hub';
        }
        
        // Instruction links
        if (linkText.match(/^(Access|Study|Apply|Use|Browse|Navigate|Execute|Implement)/)) {
            return 'instruction';
        }
        
        // Navigation breadcrumbs
        if (linkPath.includes('../') && (linkText.includes('🏠') || linkText.includes('⚡') || linkText.includes('🏗️'))) {
            return 'navigation';
        }
        
        // Default reference type
        return 'reference';
    }

    /**
     * Get line number for a character index in content
     */
    getLineNumber(content, index) {
        return content.substring(0, index).split('\n').length;
    }

    /**
     * Extract context around a reference for validation
     */
    extractContext(content, index) {
        const contextRadius = 100;
        const start = Math.max(0, index - contextRadius);
        const end = Math.min(content.length, index + contextRadius);
        return content.substring(start, end).replace(/\n/g, ' ');
    }

    /**
     * Validate all cross-references for integrity
     */
    async validateCrossReferences(baseDirectory) {
        const validationResults = {
            total_references: 0,
            valid_references: 0,
            invalid_references: 0,
            broken_links: [],
            validation_errors: [],
            warnings: []
        };

        try {
            const crossReferences = this.registry.cross_reference_registry.discovered_references || {};
            
            for (const [filePath, references] of Object.entries(crossReferences)) {
                for (const reference of references) {
                    validationResults.total_references++;
                    
                    const validationResult = await this.validateSingleReference(
                        filePath, 
                        reference, 
                        baseDirectory
                    );
                    
                    if (validationResult.isValid) {
                        validationResults.valid_references++;
                    } else {
                        validationResults.invalid_references++;
                        validationResults.broken_links.push({
                            file: filePath,
                            reference: reference,
                            error: validationResult.error
                        });
                    }
                    
                    // Collect warnings
                    if (validationResult.warnings) {
                        validationResults.warnings.push(...validationResult.warnings);
                    }
                }
            }
            
            // Update registry with validation results
            this.registry.validation_results = {
                last_validation: new Date().toISOString(),
                ...validationResults
            };
            
            console.log(`📊 Validation complete: ${validationResults.valid_references}/${validationResults.total_references} references valid`);
            return validationResults;
            
        } catch (error) {
            console.error(`❌ Cross-reference validation failed: ${error.message}`);
            throw error;
        }
    }

    /**
     * Validate a single cross-reference
     */
    async validateSingleReference(sourceFile, reference, baseDirectory) {
        const result = {
            isValid: false,
            error: null,
            warnings: []
        };

        try {
            // Resolve relative path
            const sourceDir = path.dirname(sourceFile);
            const targetPath = path.resolve(sourceDir, reference.path.split('#')[0]);
            
            // Check if target file exists
            if (!fs.existsSync(targetPath)) {
                result.error = `Target file does not exist: ${targetPath}`;
                return result;
            }
            
            // Check if target is within allowed base directory
            const relativePath = path.relative(baseDirectory, targetPath);
            if (relativePath.startsWith('..')) {
                result.warnings.push(`Reference points outside base directory: ${targetPath}`);
            }
            
            // Validate reference type consistency
            const expectedType = this.classifyReferenceType(reference.text, reference.path);
            if (reference.type !== expectedType) {
                result.warnings.push(
                    `Reference type mismatch: expected ${expectedType}, got ${reference.type}`
                );
            }
            
            // Validate anchor if present
            if (reference.path.includes('#')) {
                const anchor = reference.path.split('#')[1];
                const anchorExists = await this.validateAnchor(targetPath, anchor);
                if (!anchorExists) {
                    result.warnings.push(`Anchor #${anchor} not found in target file`);
                }
            }
            
            result.isValid = true;
            return result;
            
        } catch (error) {
            result.error = `Validation error: ${error.message}`;
            return result;
        }
    }

    /**
     * Validate that an anchor exists in the target file
     */
    async validateAnchor(filePath, anchor) {
        try {
            const content = fs.readFileSync(filePath, 'utf8');
            
            // Check for heading that would generate this anchor
            const headingRegex = new RegExp(`^#+\\s+.*${anchor.replace(/-/g, '\\s+')}.*$`, 'mi');
            const explicitAnchorRegex = new RegExp(`<a\\s+[^>]*name=["']${anchor}["']`, 'i');
            const idAttributeRegex = new RegExp(`<[^>]+\\s+id=["']${anchor}["']`, 'i');
            
            return headingRegex.test(content) || 
                   explicitAnchorRegex.test(content) || 
                   idAttributeRegex.test(content);
        } catch (error) {
            console.warn(`⚠️  Failed to validate anchor in ${filePath}: ${error.message}`);
            return false;
        }
    }

    /**
     * Generate pattern usage report
     */
    generateUsageReport() {
        const report = {
            timestamp: new Date().toISOString(),
            summary: {
                total_patterns: this.registry.registry_metadata.total_patterns,
                active_patterns: this.registry.registry_metadata.active_patterns,
                total_cross_references: 0,
                valid_references: 0,
                automation_effectiveness: {}
            },
            pattern_usage: {},
            validation_summary: {},
            recommendations: []
        };

        // Calculate cross-reference statistics
        const discoveredRefs = this.registry.cross_reference_registry.discovered_references || {};
        report.summary.total_cross_references = Object.values(discoveredRefs)
            .reduce((total, refs) => total + refs.length, 0);

        // Calculate validation statistics
        if (this.registry.validation_results) {
            report.summary.valid_references = this.registry.validation_results.valid_references;
            report.validation_summary = {
                validation_rate: 
                    (this.registry.validation_results.valid_references / 
                     this.registry.validation_results.total_references * 100).toFixed(2) + '%',
                broken_links: this.registry.validation_results.broken_links.length,
                warnings: this.registry.validation_results.warnings.length
            };
        }

        // Generate recommendations
        if (this.registry.validation_results && this.registry.validation_results.broken_links.length > 0) {
            report.recommendations.push('Fix broken cross-references to improve system integrity');
        }

        if (report.summary.total_cross_references > 100) {
            report.recommendations.push('Consider implementing automated cross-reference generation');
        }

        console.log('📊 Usage report generated');
        return report;
    }

    /**
     * Export validation results for external systems
     */
    exportValidationResults(outputPath) {
        try {
            const report = this.generateUsageReport();
            fs.writeFileSync(outputPath, JSON.stringify(report, null, 2), 'utf8');
            console.log(`📄 Validation results exported to ${outputPath}`);
            return report;
        } catch (error) {
            console.error(`❌ Failed to export validation results: ${error.message}`);
            throw error;
        }
    }
}

// CLI Interface
if (require.main === module) {
    const args = process.argv.slice(2);
    const command = args[0];

    const registryPath = './pattern-registry.json';
    const patternsBasePath = './modules/';
    const architectureBasePath = '../../';

    const manager = new CrossReferenceManager(registryPath, patternsBasePath);

    async function main() {
        try {
            switch (command) {
                case 'scan':
                    console.log('🔍 Scanning cross-references...');
                    await manager.scanCrossReferences(architectureBasePath);
                    manager.updateRegistry();
                    break;

                case 'validate':
                    console.log('✅ Validating cross-references...');
                    await manager.validateCrossReferences(architectureBasePath);
                    manager.updateRegistry();
                    break;

                case 'report':
                    console.log('📊 Generating usage report...');
                    const report = manager.generateUsageReport();
                    const outputPath = args[1] || './validation-report.json';
                    manager.exportValidationResults(outputPath);
                    break;

                case 'full-analysis':
                    console.log('🚀 Performing full cross-reference analysis...');
                    await manager.scanCrossReferences(architectureBasePath);
                    await manager.validateCrossReferences(architectureBasePath);
                    const fullReport = manager.generateUsageReport();
                    manager.updateRegistry();
                    manager.exportValidationResults('./full-analysis-report.json');
                    console.log('✨ Full analysis complete!');
                    break;

                default:
                    console.log('Usage: node cross-reference-manager.js <command>');
                    console.log('Commands:');
                    console.log('  scan              - Scan for cross-references');
                    console.log('  validate          - Validate cross-reference integrity');
                    console.log('  report [output]   - Generate usage report');
                    console.log('  full-analysis     - Perform complete analysis');
            }
        } catch (error) {
            console.error(`❌ Operation failed: ${error.message}`);
            process.exit(1);
        }
    }

    main();
}

module.exports = CrossReferenceManager;