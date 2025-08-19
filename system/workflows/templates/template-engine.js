#!/usr/bin/env node

/**
 * Enhanced Template Integration Engine v2.0
 * Automatic import resolution with cascading inheritance and conditional imports
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

class TemplateEngine {
    constructor(basePath) {
        this.basePath = basePath || path.join(__dirname, '../modules');
        this.templateCache = new Map();
        this.variableStack = [];
        this.compiledVariants = new Map();
        this.complexityThresholds = {
            simple: { min: 1, max: 10 },
            moderate: { min: 10, max: 30 },
            complex: { min: 30, max: 60 },
            enterprise: { min: 60, max: Infinity }
        };
    }

    /**
     * Process template file with automatic import resolution
     * @param {string} templatePath - Path to template file
     * @param {Object} variables - Template variables for substitution
     * @param {string} complexity - Complexity level (simple|moderate|complex|enterprise)
     * @returns {Promise<string>} - Processed template content
     */
    async processTemplate(templatePath, variables = {}, complexity = 'moderate') {
        const cacheKey = `${templatePath}:${complexity}:${JSON.stringify(variables)}`;
        
        // Check for pre-compiled variant
        if (this.compiledVariants.has(cacheKey)) {
            return this.compiledVariants.get(cacheKey);
        }

        // Read template content
        const fullPath = path.resolve(this.basePath, templatePath);
        if (!fs.existsSync(fullPath)) {
            throw new Error(`Template not found: ${templatePath}`);
        }

        let content = fs.readFileSync(fullPath, 'utf8');
        
        // Push variables to stack for cascading inheritance
        this.variableStack.push(variables);
        
        try {
            // Process automatic imports
            content = await this.processImports(content, complexity);
            
            // Process template sections
            content = await this.processSectionIncludes(content, complexity);
            
            // Process variable substitution with cascading inheritance
            content = this.processVariableSubstitution(content);
            
            // Process conditional imports based on complexity
            content = this.processConditionalImports(content, complexity);
            
            // Cache compiled variant for performance
            this.compiledVariants.set(cacheKey, content);
            
            return content;
        } finally {
            // Pop variables from stack
            this.variableStack.pop();
        }
    }

    /**
     * Process automatic import resolution
     * Syntax: {{import: template-file.md}}
     */
    async processImports(content, complexity) {
        const importRegex = /\{\{import:\s*([^}]+)\}\}/g;
        let match;
        
        while ((match = importRegex.exec(content)) !== null) {
            const importFile = match[1].trim();
            const importedContent = await this.processTemplate(importFile, this.getCurrentVariables(), complexity);
            content = content.replace(match[0], importedContent);
        }
        
        return content;
    }

    /**
     * Process section-specific template includes
     * Syntax: {{template: template-file.md | section: section-name}}
     */
    async processSectionIncludes(content, complexity) {
        const sectionRegex = /\{\{template:\s*([^|]+)\|\s*section:\s*([^}]+)\}\}/g;
        let match;
        
        while ((match = sectionRegex.exec(content)) !== null) {
            const templateFile = match[1].trim();
            const sectionName = match[2].trim();
            
            const templateContent = await this.processTemplate(templateFile, this.getCurrentVariables(), complexity);
            const sectionContent = this.extractSection(templateContent, sectionName);
            
            content = content.replace(match[0], sectionContent);
        }
        
        return content;
    }

    /**
     * Process conditional imports based on complexity requirements
     * Syntax: {{conditional: complexity=complex|enterprise, template: template-file.md}}
     */
    processConditionalImports(content, complexity) {
        const conditionalRegex = /\{\{conditional:\s*complexity=([^,]+),\s*template:\s*([^}]+)\}\}/g;
        let match;
        
        while ((match = conditionalRegex.exec(content)) !== null) {
            const requiredComplexities = match[1].split('|').map(c => c.trim());
            const templateFile = match[2].trim();
            
            if (requiredComplexities.includes(complexity)) {
                // Include the template for this complexity level
                const includePath = path.resolve(this.basePath, templateFile);
                if (fs.existsSync(includePath)) {
                    const includeContent = fs.readFileSync(includePath, 'utf8');
                    content = content.replace(match[0], includeContent);
                } else {
                    content = content.replace(match[0], `<!-- Template not found: ${templateFile} -->`);
                }
            } else {
                // Remove the conditional block for this complexity level
                content = content.replace(match[0], '');
            }
        }
        
        return content;
    }

    /**
     * Process variable substitution with cascading inheritance
     * Variables from the most recent stack level override previous levels
     */
    processVariableSubstitution(content) {
        const variables = this.getCurrentVariables();
        
        // Process simple variable substitution: {variable-name}
        const variableRegex = /\{([^}]+)\}/g;
        content = content.replace(variableRegex, (match, variableName) => {
            const cleanName = variableName.replace(/-/g, '_');
            return variables[cleanName] || variables[variableName] || match;
        });
        
        // Process configuration comments: <!-- Configure: {key: value, key2: value2} -->
        const configRegex = /<!--\s*Configure:\s*\{([^}]+)\}\s*-->/g;
        let configMatch;
        
        while ((configMatch = configRegex.exec(content)) !== null) {
            const configString = configMatch[1];
            try {
                const configVars = this.parseConfigString(configString);
                Object.assign(variables, configVars);
                
                // Remove the configuration comment after processing
                content = content.replace(configMatch[0], '');
            } catch (error) {
                console.warn(`Failed to parse config: ${configString}`, error);
            }
        }
        
        return content;
    }

    /**
     * Parse configuration string into variables object
     */
    parseConfigString(configString) {
        const variables = {};
        const pairs = configString.split(',');
        
        pairs.forEach(pair => {
            const [key, value] = pair.split(':').map(s => s.trim());
            if (key && value) {
                variables[key] = value.replace(/['"]/g, '');
            }
        });
        
        return variables;
    }

    /**
     * Extract specific section from template content
     */
    extractSection(content, sectionName) {
        // Handle different section naming conventions
        const sectionPatterns = [
            new RegExp(`## ${sectionName.replace(/-/g, '[ -]')}([\\s\\S]*?)(?=## |$)`, 'i'),
            new RegExp(`### ${sectionName.replace(/-/g, '[ -]')}([\\s\\S]*?)(?=### |## |$)`, 'i'),
            new RegExp(`#### ${sectionName.replace(/-/g, '[ -]')}([\\s\\S]*?)(?=#### |### |## |$)`, 'i')
        ];
        
        for (const pattern of sectionPatterns) {
            const match = content.match(pattern);
            if (match) {
                return match[1].trim();
            }
        }
        
        // If section not found, return empty string with comment
        return `<!-- Section "${sectionName}" not found -->`;
    }

    /**
     * Get current variables with cascading inheritance
     */
    getCurrentVariables() {
        const merged = {};
        this.variableStack.forEach(vars => {
            Object.assign(merged, vars);
        });
        return merged;
    }

    /**
     * Pre-compile template variants for performance optimization
     */
    async precompileVariants(templateFiles, complexityLevels = ['simple', 'moderate', 'complex', 'enterprise']) {
        const commonVariables = {
            'conversation-id': 'template_integration_enhancement',
            'agent-specialist-type': 'template-integration-enhancement-specialist',
            'workflow-purpose': 'template-integration',
            'target-area': 'workflow-modules',
            'implementation-type': 'template-engine'
        };

        for (const templateFile of templateFiles) {
            for (const complexity of complexityLevels) {
                try {
                    await this.processTemplate(templateFile, commonVariables, complexity);
                    console.log(`Pre-compiled: ${templateFile} [${complexity}]`);
                } catch (error) {
                    console.warn(`Failed to pre-compile ${templateFile} [${complexity}]:`, error.message);
                }
            }
        }
    }

    /**
     * Validate template import functionality across all workflow modules
     */
    async validateTemplateIntegration(workflowDir) {
        const validationResults = {
            totalFiles: 0,
            processedSuccessfully: 0,
            errors: [],
            warnings: []
        };

        const workflowFiles = fs.readdirSync(workflowDir)
            .filter(file => file.endsWith('.md'))
            .filter(file => !file.startsWith('_core'));

        for (const file of workflowFiles) {
            validationResults.totalFiles++;
            
            try {
                const filePath = path.join(workflowDir, file);
                const content = fs.readFileSync(filePath, 'utf8');
                
                // Check for template syntax usage
                const hasImports = /\{\{import:/.test(content);
                const hasTemplates = /\{\{template:/.test(content);
                const hasConditionals = /\{\{conditional:/.test(content);
                
                if (hasImports || hasTemplates || hasConditionals) {
                    // Validate template processing
                    await this.processTemplate(path.relative(this.basePath, filePath), {}, 'moderate');
                    validationResults.processedSuccessfully++;
                } else {
                    validationResults.warnings.push(`${file}: No template syntax found`);
                    validationResults.processedSuccessfully++;
                }
                
            } catch (error) {
                validationResults.errors.push({
                    file,
                    error: error.message
                });
            }
        }

        return validationResults;
    }

    /**
     * Generate performance metrics for template engine
     */
    getPerformanceMetrics() {
        return {
            cacheSize: this.templateCache.size,
            compiledVariants: this.compiledVariants.size,
            variableStackDepth: this.variableStack.length,
            availableComplexityLevels: Object.keys(this.complexityThresholds)
        };
    }
}

module.exports = TemplateEngine;

// CLI usage support
if (require.main === module) {
    const engine = new TemplateEngine();
    
    const command = process.argv[2];
    const templateFile = process.argv[3];
    const complexity = process.argv[4] || 'moderate';
    
    switch (command) {
        case 'process':
            engine.processTemplate(templateFile, {}, complexity)
                .then(result => console.log(result))
                .catch(error => console.error('Error:', error.message));
            break;
            
        case 'validate':
            const workflowDir = templateFile || path.join(__dirname, '../modules');
            engine.validateTemplateIntegration(workflowDir)
                .then(results => console.log(JSON.stringify(results, null, 2)))
                .catch(error => console.error('Error:', error.message));
            break;
            
        case 'precompile':
            const templates = ['_core-agent-deployment-template.md', '_core-workflow-integration-template.md', '_core-quality-validation-template.md'];
            engine.precompileVariants(templates)
                .then(() => console.log('Pre-compilation completed'))
                .catch(error => console.error('Error:', error.message));
            break;
            
        default:
            console.log('Usage: node template-engine.js [process|validate|precompile] [template-file] [complexity]');
    }
}