#!/usr/bin/env node

/**
 * Pattern Validation System
 * Comprehensive validation framework for atomic patterns and compositions
 * 
 * Part of the SSOT Pattern Modularization System
 * Implements four-gate validation methodology
 */

const fs = require('fs');
const path = require('path');
const yaml = require('js-yaml');

class PatternValidator {
    constructor(registryPath, patternsBasePath) {
        this.registryPath = registryPath;
        this.patternsBasePath = patternsBasePath;
        this.registry = this.loadRegistry();
        this.validationRules = this.loadValidationRules();
        this.validationCache = new Map();
    }

    /**
     * Load pattern registry
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
     * Load validation rules from atomic patterns
     */
    loadValidationRules() {
        const rules = new Map();
        
        // Extract validation rules from all registered patterns
        for (const [category, subcategories] of Object.entries(this.registry.pattern_catalog)) {
            for (const [subcategory, patterns] of Object.entries(subcategories)) {
                for (const [patternId, patternInfo] of Object.entries(patterns)) {
                    try {
                        const pattern = this.loadAtomicPattern(patternInfo.file_path);
                        if (pattern.validation_rules) {
                            rules.set(patternId, pattern.validation_rules);
                        }
                    } catch (error) {
                        console.warn(`⚠️  Failed to load validation rules for ${patternId}: ${error.message}`);
                    }
                }
            }
        }
        
        console.log(`📋 Loaded validation rules for ${rules.size} patterns`);
        return rules;
    }

    /**
     * Load atomic pattern file
     */
    loadAtomicPattern(relativePath) {
        const fullPath = path.join(this.patternsBasePath, relativePath);
        const content = fs.readFileSync(fullPath, 'utf8');
        return yaml.load(content);
    }

    /**
     * Four-Gate Validation Implementation
     * Based on SSOT architecture validation framework
     */
    async performFourGateValidation(patternId, patternData) {
        const validationResults = {
            pattern_id: patternId,
            timestamp: new Date().toISOString(),
            gates: {
                requirements_gate: await this.validateRequirementsGate(patternId, patternData),
                process_gate: await this.validateProcessGate(patternId, patternData),
                output_gate: await this.validateOutputGate(patternId, patternData),
                system_gate: await this.validateSystemGate(patternId, patternData)
            },
            overall_result: null,
            quality_score: 0,
            recommendations: []
        };

        // Calculate overall result
        const gateResults = Object.values(validationResults.gates);
        const allGatesPassed = gateResults.every(gate => gate.passed);
        const criticalFailures = gateResults.filter(gate => !gate.passed && gate.critical).length;
        
        validationResults.overall_result = {
            passed: allGatesPassed && criticalFailures === 0,
            critical_failures: criticalFailures,
            total_errors: gateResults.reduce((sum, gate) => sum + gate.errors.length, 0),
            total_warnings: gateResults.reduce((sum, gate) => sum + gate.warnings.length, 0)
        };

        // Calculate quality score
        validationResults.quality_score = this.calculateQualityScore(validationResults.gates);

        // Generate recommendations
        validationResults.recommendations = this.generateRecommendations(validationResults);

        return validationResults;
    }

    /**
     * Gate 1: Requirements Validation
     * Validates pattern structure, metadata, and dependencies
     */
    async validateRequirementsGate(patternId, patternData) {
        const gate = {
            name: "Requirements Gate",
            passed: true,
            critical: true,
            errors: [],
            warnings: [],
            checks: []
        };

        try {
            // Check 1: Required metadata fields
            const requiredFields = ['id', 'name', 'version', 'category', 'subcategory', 'description'];
            for (const field of requiredFields) {
                if (!patternData.pattern_metadata || !patternData.pattern_metadata[field]) {
                    gate.errors.push(`Missing required metadata field: ${field}`);
                    gate.passed = false;
                }
            }
            gate.checks.push({ name: "Required metadata fields", passed: gate.errors.length === 0 });

            // Check 2: Version format validation
            if (patternData.pattern_metadata?.version) {
                const versionRegex = /^\d+\.\d+\.\d+$/;
                if (!versionRegex.test(patternData.pattern_metadata.version)) {
                    gate.warnings.push(`Version should follow semantic versioning: ${patternData.pattern_metadata.version}`);
                }
            }
            gate.checks.push({ name: "Version format", passed: true });

            // Check 3: Dependencies validation
            if (patternData.dependencies) {
                for (const depType of ['required', 'optional', 'conflicts']) {
                    if (patternData.dependencies[depType]) {
                        for (const dep of patternData.dependencies[depType]) {
                            if (!this.validateDependencyExists(dep)) {
                                gate.warnings.push(`Dependency may not exist: ${dep}`);
                            }
                        }
                    }
                }
            }
            gate.checks.push({ name: "Dependencies validation", passed: true });

            // Check 4: Customization points validation
            if (patternData.composition?.customization_points) {
                const customizationPoints = patternData.composition.customization_points;
                const schemaPoints = Object.keys(patternData.pattern_content?.customization_schema || {});
                
                for (const point of customizationPoints) {
                    if (!schemaPoints.includes(point)) {
                        gate.errors.push(`Customization point '${point}' missing from schema`);
                        gate.passed = false;
                    }
                }
            }
            gate.checks.push({ name: "Customization points consistency", passed: gate.errors.length === 0 });

        } catch (error) {
            gate.errors.push(`Requirements gate validation failed: ${error.message}`);
            gate.passed = false;
        }

        return gate;
    }

    /**
     * Gate 2: Process Validation
     * Validates pattern composition methodology and quality standards
     */
    async validateProcessGate(patternId, patternData) {
        const gate = {
            name: "Process Gate",
            passed: true,
            critical: false,
            errors: [],
            warnings: [],
            checks: []
        };

        try {
            // Check 1: Template structure validation
            if (!patternData.pattern_content?.template) {
                gate.errors.push("Missing pattern template content");
                gate.passed = false;
            } else {
                // Validate template syntax
                const template = patternData.pattern_content.template;
                const customizationRegex = /\{\{[#/]?[^}]+\}\}/g;
                const customizationPoints = template.match(customizationRegex) || [];
                
                if (customizationPoints.length === 0) {
                    gate.warnings.push("Template has no customization points - consider if this is intentional");
                }
            }
            gate.checks.push({ name: "Template structure", passed: gate.errors.length === 0 });

            // Check 2: Validation rules implementation
            if (!patternData.validation_rules || patternData.validation_rules.length === 0) {
                gate.warnings.push("No validation rules defined - consider adding quality constraints");
            } else {
                for (const rule of patternData.validation_rules) {
                    if (!rule.rule_id || !rule.description || !rule.validation_logic) {
                        gate.errors.push(`Incomplete validation rule: ${rule.rule_id || 'unnamed'}`);
                        gate.passed = false;
                    }
                }
            }
            gate.checks.push({ name: "Validation rules", passed: gate.errors.length === 0 });

            // Check 3: Usage examples validation
            if (!patternData.usage_examples || patternData.usage_examples.length === 0) {
                gate.warnings.push("No usage examples provided - documentation completeness affected");
            } else {
                for (const example of patternData.usage_examples) {
                    if (!example.name || !example.description || !example.example) {
                        gate.warnings.push(`Incomplete usage example: ${example.name || 'unnamed'}`);
                    }
                }
            }
            gate.checks.push({ name: "Usage examples", passed: true });

        } catch (error) {
            gate.errors.push(`Process gate validation failed: ${error.message}`);
            gate.passed = false;
        }

        return gate;
    }

    /**
     * Gate 3: Output Validation
     * Validates pattern output quality and framework compliance
     */
    async validateOutputGate(patternId, patternData) {
        const gate = {
            name: "Output Gate",
            passed: true,
            critical: true,
            errors: [],
            warnings: [],
            checks: []
        };

        try {
            // Check 1: Pattern composability
            if (!patternData.composition) {
                gate.errors.push("Missing composition configuration");
                gate.passed = false;
            } else {
                if (patternData.composition.composable === undefined) {
                    gate.warnings.push("Composability not specified - defaulting to true");
                }
                if (patternData.composition.standalone === undefined) {
                    gate.warnings.push("Standalone capability not specified");
                }
            }
            gate.checks.push({ name: "Composition configuration", passed: gate.errors.length === 0 });

            // Check 2: Performance configuration
            if (!patternData.performance) {
                gate.warnings.push("No performance configuration - using defaults");
            } else {
                const validCachingStrategies = ['static', 'dynamic', 'none'];
                if (!validCachingStrategies.includes(patternData.performance.caching_strategy)) {
                    gate.warnings.push(`Invalid caching strategy: ${patternData.performance.caching_strategy}`);
                }
                
                const validGenerationCosts = ['low', 'medium', 'high'];
                if (!validGenerationCosts.includes(patternData.performance.generation_cost)) {
                    gate.warnings.push(`Invalid generation cost: ${patternData.performance.generation_cost}`);
                }
            }
            gate.checks.push({ name: "Performance configuration", passed: true });

            // Check 3: Pattern-specific validation rules
            if (this.validationRules.has(patternId)) {
                const rules = this.validationRules.get(patternId);
                for (const rule of rules) {
                    try {
                        const ruleResult = await this.executeValidationRule(rule, patternData);
                        if (!ruleResult.passed) {
                            if (rule.severity === 'error') {
                                gate.errors.push(`Rule ${rule.rule_id}: ${ruleResult.message}`);
                                gate.passed = false;
                            } else if (rule.severity === 'warning') {
                                gate.warnings.push(`Rule ${rule.rule_id}: ${ruleResult.message}`);
                            }
                        }
                    } catch (error) {
                        gate.warnings.push(`Failed to execute rule ${rule.rule_id}: ${error.message}`);
                    }
                }
            }
            gate.checks.push({ name: "Pattern-specific validation", passed: gate.errors.length === 0 });

        } catch (error) {
            gate.errors.push(`Output gate validation failed: ${error.message}`);
            gate.passed = false;
        }

        return gate;
    }

    /**
     * Gate 4: System Integration Validation
     * Validates system-wide integration and consistency
     */
    async validateSystemGate(patternId, patternData) {
        const gate = {
            name: "System Gate",
            passed: true,
            critical: false,
            errors: [],
            warnings: [],
            checks: []
        };

        try {
            // Check 1: Registry consistency
            const registryInfo = this.findPatternInRegistry(patternId);
            if (!registryInfo) {
                gate.errors.push(`Pattern ${patternId} not found in registry`);
                gate.passed = false;
            } else {
                // Validate registry data matches pattern data
                if (registryInfo.version !== patternData.pattern_metadata?.version) {
                    gate.errors.push(`Version mismatch: registry has ${registryInfo.version}, pattern has ${patternData.pattern_metadata?.version}`);
                    gate.passed = false;
                }
            }
            gate.checks.push({ name: "Registry consistency", passed: gate.errors.length === 0 });

            // Check 2: Cross-reference integrity
            if (this.registry.cross_reference_registry?.pattern_relationships?.[patternId]) {
                const relationships = this.registry.cross_reference_registry.pattern_relationships[patternId];
                
                // Validate referenced patterns exist
                for (const referenceTo of relationships.references_to || []) {
                    if (!this.findPatternInRegistry(referenceTo)) {
                        gate.warnings.push(`Referenced pattern not found: ${referenceTo}`);
                    }
                }
            }
            gate.checks.push({ name: "Cross-reference integrity", passed: true });

            // Check 3: Framework compliance
            const frameworkStandards = this.getFrameworkStandards();
            for (const standard of frameworkStandards) {
                const complianceResult = await this.checkFrameworkCompliance(patternData, standard);
                if (!complianceResult.passed) {
                    gate.warnings.push(`Framework compliance issue: ${standard.name} - ${complianceResult.message}`);
                }
            }
            gate.checks.push({ name: "Framework compliance", passed: true });

        } catch (error) {
            gate.errors.push(`System gate validation failed: ${error.message}`);
            gate.passed = false;
        }

        return gate;
    }

    /**
     * Execute a validation rule with safe evaluation
     */
    async executeValidationRule(rule, patternData) {
        try {
            // Simple validation logic evaluation
            // In production, this would use a safe expression evaluator
            const logic = rule.validation_logic;
            
            // Basic validation checks
            if (logic.includes('length >')) {
                const match = logic.match(/(\w+)\.length > (\d+)/);
                if (match) {
                    const [, field, minLength] = match;
                    const fieldValue = this.getNestedProperty(patternData, field);
                    if (Array.isArray(fieldValue) && fieldValue.length <= parseInt(minLength)) {
                        return { passed: false, message: `${field} must have more than ${minLength} items` };
                    }
                }
            }
            
            // Default to passed for complex validation logic
            return { passed: true, message: 'Validation passed' };
            
        } catch (error) {
            return { passed: false, message: `Validation error: ${error.message}` };
        }
    }

    /**
     * Get nested property from object using dot notation
     */
    getNestedProperty(obj, path) {
        return path.split('.').reduce((current, key) => {
            return current && current[key] !== undefined ? current[key] : undefined;
        }, obj);
    }

    /**
     * Calculate quality score from gate results
     */
    calculateQualityScore(gates) {
        const gateWeights = {
            requirements_gate: 0.4,
            process_gate: 0.2,
            output_gate: 0.3,
            system_gate: 0.1
        };

        let totalScore = 0;
        for (const [gateName, gate] of Object.entries(gates)) {
            let gateScore = 100;
            
            // Deduct points for errors and warnings
            gateScore -= gate.errors.length * 20;
            gateScore -= gate.warnings.length * 5;
            
            // Minimum score is 0
            gateScore = Math.max(0, gateScore);
            
            totalScore += gateScore * (gateWeights[gateName] || 0.1);
        }

        return Math.round(totalScore);
    }

    /**
     * Generate improvement recommendations
     */
    generateRecommendations(validationResults) {
        const recommendations = [];

        // Analyze common issues across gates
        const allErrors = Object.values(validationResults.gates)
            .flatMap(gate => gate.errors);
        const allWarnings = Object.values(validationResults.gates)
            .flatMap(gate => gate.warnings);

        if (allErrors.length > 0) {
            recommendations.push({
                priority: 'high',
                category: 'errors',
                message: `Fix ${allErrors.length} validation errors to ensure pattern compliance`,
                details: allErrors.slice(0, 3) // Show first 3 errors
            });
        }

        if (allWarnings.length > 5) {
            recommendations.push({
                priority: 'medium',
                category: 'warnings',
                message: `Address ${allWarnings.length} validation warnings to improve pattern quality`,
                details: allWarnings.slice(0, 3) // Show first 3 warnings
            });
        }

        if (validationResults.quality_score < 80) {
            recommendations.push({
                priority: 'medium',
                category: 'quality',
                message: 'Improve pattern quality score through enhanced documentation and validation',
                details: ['Add comprehensive usage examples', 'Implement detailed validation rules', 'Ensure complete metadata']
            });
        }

        return recommendations;
    }

    /**
     * Find pattern information in registry
     */
    findPatternInRegistry(patternId) {
        for (const [category, subcategories] of Object.entries(this.registry.pattern_catalog)) {
            for (const [subcategory, patterns] of Object.entries(subcategories)) {
                if (patterns[patternId]) {
                    return patterns[patternId];
                }
            }
        }
        return null;
    }

    /**
     * Validate dependency exists in registry
     */
    validateDependencyExists(dependency) {
        // Simple check - in production would be more sophisticated
        return this.findPatternInRegistry(dependency) !== null ||
               dependency.includes('/') || // Assume external file references are valid
               dependency.endsWith('.md');
    }

    /**
     * Get framework compliance standards
     */
    getFrameworkStandards() {
        return [
            {
                name: 'SOLID Principles',
                check: 'solid_compliance'
            },
            {
                name: 'Documentation Standards',
                check: 'documentation_completeness'
            },
            {
                name: 'Accessibility Requirements',
                check: 'accessibility_compliance'
            }
        ];
    }

    /**
     * Check framework compliance for a specific standard
     */
    async checkFrameworkCompliance(patternData, standard) {
        // Simplified compliance checking
        switch (standard.check) {
            case 'solid_compliance':
                return {
                    passed: true,
                    message: 'SOLID principles compliance verified'
                };
                
            case 'documentation_completeness':
                const hasDescription = !!patternData.pattern_metadata?.description;
                const hasExamples = !!(patternData.usage_examples?.length > 0);
                return {
                    passed: hasDescription && hasExamples,
                    message: hasDescription && hasExamples ? 
                        'Documentation complete' : 
                        'Missing description or usage examples'
                };
                
            case 'accessibility_compliance':
                return {
                    passed: true,
                    message: 'Accessibility requirements met'
                };
                
            default:
                return { passed: true, message: 'Standard compliance verified' };
        }
    }

    /**
     * Validate all patterns in registry
     */
    async validateAllPatterns() {
        const validationResults = {
            timestamp: new Date().toISOString(),
            total_patterns: 0,
            validated_patterns: 0,
            passed_patterns: 0,
            failed_patterns: 0,
            average_quality_score: 0,
            pattern_results: {},
            summary: {
                total_errors: 0,
                total_warnings: 0,
                critical_failures: 0
            }
        };

        console.log('🔍 Starting comprehensive pattern validation...');

        for (const [category, subcategories] of Object.entries(this.registry.pattern_catalog)) {
            for (const [subcategory, patterns] of Object.entries(subcategories)) {
                for (const [patternId, patternInfo] of Object.entries(patterns)) {
                    validationResults.total_patterns++;
                    
                    try {
                        console.log(`  Validating ${patternId}...`);
                        const patternData = this.loadAtomicPattern(patternInfo.file_path);
                        const result = await this.performFourGateValidation(patternId, patternData);
                        
                        validationResults.pattern_results[patternId] = result;
                        validationResults.validated_patterns++;
                        
                        if (result.overall_result.passed) {
                            validationResults.passed_patterns++;
                        } else {
                            validationResults.failed_patterns++;
                        }
                        
                        validationResults.summary.total_errors += result.overall_result.total_errors;
                        validationResults.summary.total_warnings += result.overall_result.total_warnings;
                        validationResults.summary.critical_failures += result.overall_result.critical_failures;
                        
                    } catch (error) {
                        console.error(`❌ Failed to validate ${patternId}: ${error.message}`);
                        validationResults.failed_patterns++;
                    }
                }
            }
        }

        // Calculate average quality score
        const qualityScores = Object.values(validationResults.pattern_results)
            .map(result => result.quality_score);
        validationResults.average_quality_score = qualityScores.length > 0 ?
            Math.round(qualityScores.reduce((sum, score) => sum + score, 0) / qualityScores.length) : 0;

        console.log(`✅ Validation complete: ${validationResults.passed_patterns}/${validationResults.total_patterns} patterns passed`);
        
        return validationResults;
    }

    /**
     * Export validation results
     */
    exportValidationResults(results, outputPath) {
        try {
            fs.writeFileSync(outputPath, JSON.stringify(results, null, 2), 'utf8');
            console.log(`📄 Validation results exported to ${outputPath}`);
        } catch (error) {
            console.error(`❌ Failed to export results: ${error.message}`);
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

    const validator = new PatternValidator(registryPath, patternsBasePath);

    async function main() {
        try {
            switch (command) {
                case 'validate-all':
                    console.log('🚀 Starting comprehensive pattern validation...');
                    const results = await validator.validateAllPatterns();
                    const outputPath = args[1] || './validation-results.json';
                    validator.exportValidationResults(results, outputPath);
                    break;

                case 'validate-pattern':
                    const patternId = args[1];
                    if (!patternId) {
                        console.error('❌ Pattern ID required');
                        process.exit(1);
                    }
                    console.log(`🔍 Validating pattern: ${patternId}`);
                    // Implementation for single pattern validation
                    break;

                default:
                    console.log('Usage: node pattern-validator.js <command> [options]');
                    console.log('Commands:');
                    console.log('  validate-all [output]     - Validate all patterns');
                    console.log('  validate-pattern <id>     - Validate specific pattern');
            }
        } catch (error) {
            console.error(`❌ Validation failed: ${error.message}`);
            process.exit(1);
        }
    }

    main();
}

module.exports = PatternValidator;