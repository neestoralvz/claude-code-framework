# Web Research Workflow with TDD/BDD

## Overview

This workflow applies Test-Driven Development and Behavior-Driven Development principles to web research, ensuring systematic information gathering with verifiable outcomes. Every research task must have defined success criteria and validation methods.

## Core Principles

- **Research Hypothesis First**: Define what you're looking for before searching
- **Evidence-Based Validation**: All findings must be verifiable and current
- **Iterative Refinement**: Improve search strategy based on results
- **Quality Gates**: Validate information quality at each step

## TDD/BDD Research Cycle

### Phase 1: RED - Define Research Requirements

**Given** a research need or question  
**When** starting research process  
**Then** create testable research criteria:

1. **Research Specification**
   ```
   RESEARCH OBJECTIVE:
   - Question: [Specific question to answer]
   - Context: [Why this research is needed]
   - Audience: [Who will use this information]
   - Timeline: [When results are needed]
   
   SUCCESS CRITERIA:
   - Information Quality: [Authoritative sources, recent data]
   - Completeness: [Specific topics to cover]
   - Actionability: [How results will be used]
   - Verification: [How to validate findings]
   
   CONSTRAINTS:
   - Time limit: [Maximum research time]
   - Source requirements: [Types of sources needed]
   - Currency: [How recent information must be]
   - Depth: [Level of detail required]
   ```

2. **Research Test Creation**
   ```python
   class ResearchTest:
       def __init__(self, objective):
           self.objective = objective
           self.findings = []
           self.sources = []
           self.validation_results = []
       
       def test_research_completeness(self):
           # RED: This should initially fail
           assert len(self.findings) >= minimum_required_findings
           assert all(finding.is_verified for finding in self.findings)
           assert all(source.is_authoritative for source in self.sources)
           assert all(finding.is_current(max_age=30) for finding in self.findings)
       
       def test_research_quality(self):
           # RED: Quality gates that must be met
           assert all(source.has_publication_date for source in self.sources)
           assert all(finding.has_supporting_evidence for finding in self.findings)
           assert len(set(source.domain for source in self.sources)) >= 3  # Diverse sources
   ```

3. **Behavior Scenarios**
   ```gherkin
   Feature: Web Research for Technical Decision
   
   Scenario: Researching database solutions
     Given I need to choose between database options
     When I research database performance benchmarks
     Then I should find current performance comparisons
     And I should find cost analysis data
     And I should find scalability information
     And all sources should be from 2024-2025
   
   Scenario: Validating research findings
     Given I have collected research findings
     When I validate the information
     Then each finding should have multiple source confirmation
     And each source should be authoritative
     And information should be current within required timeframe
   ```

### Phase 2: GREEN - Execute Research Strategy

**Given** defined research requirements  
**When** conducting research  
**Then** systematically gather information to meet criteria:

1. **Search Strategy Implementation**
   ```python
   def execute_research_strategy(research_objective):
       strategy = ResearchStrategy(research_objective)
       
       # Primary search using WebSearch
       primary_results = strategy.web_search(
           query=research_objective.primary_query,
           year_filter="2025",
           result_limit=20
       )
       
       # Deep dive using WebFetch
       detailed_findings = []
       for result in primary_results[:10]:  # Top 10 results
           content = strategy.web_fetch(result.url)
           analysis = strategy.analyze_content(content, research_objective)
           if analysis.meets_criteria():
               detailed_findings.append(analysis)
       
       return detailed_findings
   ```

2. **Information Validation Process**
   ```python
   def validate_finding(finding, research_criteria):
       validation = ValidationResult()
       
       # Source authority check
       validation.authority_score = assess_source_authority(finding.source)
       
       # Currency check
       validation.is_current = finding.publication_date >= research_criteria.min_date
       
       # Cross-reference verification
       validation.cross_references = find_corroborating_sources(finding)
       
       # Bias assessment
       validation.bias_indicators = detect_bias_indicators(finding)
       
       # Completeness check
       validation.addresses_criteria = finding.addresses_all_criteria(research_criteria)
       
       return validation
   ```

3. **Iterative Refinement**
   ```python
   def refine_search_strategy(initial_results, research_objective):
       gaps = identify_information_gaps(initial_results, research_objective)
       
       refined_queries = []
       for gap in gaps:
           # Create more specific queries
           specific_query = create_targeted_query(gap, research_objective)
           refined_queries.append(specific_query)
       
       # Execute refined searches
       additional_results = []
       for query in refined_queries:
           results = web_search(query, year_filter="2025")
           validated_results = [validate_finding(r, research_objective) for r in results]
           additional_results.extend(validated_results)
       
       return additional_results
   ```

### Phase 3: REFACTOR - Synthesize and Document

**Given** research findings that meet quality criteria  
**When** synthesizing information  
**Then** create comprehensive, actionable documentation:

1. **Information Synthesis**
   ```python
   def synthesize_research_findings(validated_findings, research_objective):
       synthesis = ResearchSynthesis(research_objective)
       
       # Group findings by theme/category
       categorized_findings = categorize_findings(validated_findings)
       
       # Identify consensus and disagreements
       consensus_items = find_consensus(categorized_findings)
       conflicting_items = find_conflicts(categorized_findings)
       
       # Create evidence hierarchy
       evidence_strength = rank_evidence_strength(validated_findings)
       
       # Generate actionable insights
       insights = generate_insights(consensus_items, evidence_strength)
       
       synthesis.add_findings(consensus_items)
       synthesis.add_conflicts(conflicting_items)
       synthesis.add_insights(insights)
       synthesis.add_recommendations(generate_recommendations(insights))
       
       return synthesis
   ```

2. **Quality Documentation**
   ```markdown
   # Research Summary: [Topic]
   
   ## Objective
   [Research question and purpose]
   
   ## Methodology
   - Search Strategy: [Queries used, sources searched]
   - Validation Criteria: [How information was validated]
   - Time Period: [Research timeframe]
   - Source Diversity: [Types of sources consulted]
   
   ## Key Findings
   
   ### High Confidence (Multiple Sources)
   - Finding 1: [Statement] 
     - Sources: [Source 1, Source 2, Source 3]
     - Evidence Quality: [Assessment]
     - Last Updated: [Date]
   
   ### Medium Confidence (Limited Sources)
   - Finding 2: [Statement]
     - Sources: [Source 1, Source 2]
     - Limitations: [What's missing]
   
   ### Conflicting Information
   - Topic: [Area of disagreement]
     - Position A: [Statement] - Sources: [List]
     - Position B: [Statement] - Sources: [List]
     - Resolution Approach: [How to resolve]
   
   ## Recommendations
   1. [Actionable recommendation based on findings]
   2. [Next steps for implementation]
   
   ## Information Gaps
   - Gap 1: [What information is still needed]
   - Gap 2: [Areas requiring further research]
   
   ## Source Bibliography
   [Formatted list of all sources with quality assessment]
   ```

## Research Scenarios

### Scenario 1: Technology Evaluation Research

**Given** need to evaluate emerging technology  
**When** researching technology options  
**Then** apply comprehensive research workflow:

```python
def test_technology_research():
    research = TechnologyResearch("AI code generation tools")
    
    # RED: Define what successful research looks like
    assert research.has_performance_benchmarks()
    assert research.has_cost_analysis()
    assert research.has_security_assessment()
    assert research.has_integration_examples()
    assert research.source_count() >= 5
    assert research.currency_days() <= 90
```

**Research Execution**:
1. WebSearch for "AI code generation tools 2025 comparison benchmarks"
2. WebFetch detailed reviews and benchmarks
3. WebSearch for "AI code generation security risks 2025"
4. WebSearch for "AI code generation integration best practices"
5. Validate all findings against quality criteria

### Scenario 2: Market Research

**Given** need to understand market trends  
**When** researching market conditions  
**Then** gather comprehensive market intelligence:

```python
def test_market_research():
    research = MarketResearch("cloud computing trends 2025")
    
    # RED: Market research success criteria
    assert research.has_market_size_data()
    assert research.has_growth_projections()
    assert research.has_competitive_analysis()
    assert research.has_pricing_information()
    assert research.sources_include_analyst_reports()
```

### Scenario 3: Best Practices Research

**Given** need to implement best practices  
**When** researching industry standards  
**Then** find authoritative guidance:

```python
def test_best_practices_research():
    research = BestPracticesResearch("API security best practices")
    
    # RED: Best practices research criteria
    assert research.has_authoritative_sources()
    assert research.has_implementation_examples()
    assert research.has_common_pitfalls_identified()
    assert research.has_compliance_requirements()
    assert research.includes_recent_updates()
```

## Quality Gates and Validation

### Information Quality Checklist
- [ ] Source authority verified (domain expertise, reputation)
- [ ] Publication date within required timeframe
- [ ] Multiple independent sources confirm key findings
- [ ] Potential bias identified and noted
- [ ] Information directly addresses research objective

### Research Completeness Checklist
- [ ] All research criteria questions answered
- [ ] Information gaps identified and documented
- [ ] Conflicting information noted and analyzed
- [ ] Actionable recommendations provided
- [ ] Source diversity meets requirements

### Validation Methods

#### Source Authority Assessment
```python
def assess_source_authority(source):
    authority_score = 0
    
    # Domain expertise indicators
    if source.domain in AUTHORITATIVE_DOMAINS:
        authority_score += 3
    if source.author_credentials_verified():
        authority_score += 2
    if source.peer_reviewed():
        authority_score += 3
    if source.citation_count() > 10:
        authority_score += 1
    
    # Bias indicators (subtract points)
    if source.has_commercial_interest():
        authority_score -= 1
    if source.lacks_references():
        authority_score -= 2
    
    return authority_score
```

#### Cross-Reference Validation
```python
def validate_claim_across_sources(claim, sources):
    supporting_sources = []
    contradicting_sources = []
    
    for source in sources:
        claim_support = source.supports_claim(claim)
        if claim_support.strongly_supports:
            supporting_sources.append(source)
        elif claim_support.contradicts:
            contradicting_sources.append(source)
    
    validation = ClaimValidation()
    validation.support_strength = len(supporting_sources) / len(sources)
    validation.contradiction_rate = len(contradicting_sources) / len(sources)
    validation.consensus_level = "high" if validation.support_strength > 0.8 else "medium" if validation.support_strength > 0.5 else "low"
    
    return validation
```

## Advanced Research Techniques

### Systematic Literature Review Approach
```python
def systematic_research_review(research_topic):
    review = SystematicReview(research_topic)
    
    # Define search terms and synonyms
    search_terms = generate_search_terms(research_topic)
    
    # Search multiple databases/sources
    for source in RESEARCH_SOURCES:
        for term in search_terms:
            results = source.search(term, filters={"year": ">=2023"})
            review.add_potential_sources(results)
    
    # Apply inclusion/exclusion criteria
    filtered_sources = review.apply_filters()
    
    # Extract and synthesize data
    synthesized_data = review.extract_and_synthesize(filtered_sources)
    
    return synthesized_data
```

### Meta-Analysis of Findings
```python
def meta_analyze_research_findings(findings_by_study):
    meta_analysis = MetaAnalysis()
    
    # Standardize metrics across studies
    standardized_findings = []
    for study_findings in findings_by_study:
        standardized = standardize_metrics(study_findings)
        standardized_findings.append(standardized)
    
    # Calculate weighted averages
    weighted_results = calculate_weighted_averages(
        standardized_findings,
        weights=lambda study: study.sample_size * study.quality_score
    )
    
    # Assess heterogeneity
    heterogeneity = assess_study_heterogeneity(standardized_findings)
    
    meta_analysis.results = weighted_results
    meta_analysis.heterogeneity = heterogeneity
    meta_analysis.confidence_intervals = calculate_confidence_intervals(weighted_results)
    
    return meta_analysis
```

## Tool Integration Patterns

### WebSearch + WebFetch Integration
```python
def comprehensive_research_pipeline(research_query, depth="medium"):
    pipeline = ResearchPipeline()
    
    # Phase 1: Broad search
    broad_results = pipeline.web_search(
        query=f"{research_query} 2025",
        num_results=20
    )
    
    # Phase 2: Deep content analysis
    detailed_content = []
    for result in broad_results[:10]:
        try:
            content = pipeline.web_fetch(result.url)
            analysis = pipeline.analyze_content(content, research_query)
            if analysis.relevance_score > 0.7:
                detailed_content.append(analysis)
        except Exception as e:
            pipeline.log_fetch_failure(result.url, e)
    
    # Phase 3: Gap identification and follow-up
    gaps = pipeline.identify_gaps(detailed_content, research_query)
    
    if gaps and depth in ["high", "comprehensive"]:
        follow_up_queries = pipeline.generate_follow_up_queries(gaps)
        for query in follow_up_queries:
            additional_results = pipeline.web_search(query, num_results=10)
            for result in additional_results[:5]:
                content = pipeline.web_fetch(result.url)
                analysis = pipeline.analyze_content(content, research_query)
                detailed_content.append(analysis)
    
    return pipeline.synthesize_findings(detailed_content)
```

### Context7 Integration for Best Practices
```python
def research_with_context7_validation(research_topic):
    # Standard web research
    web_findings = comprehensive_research_pipeline(research_topic)
    
    # Validate against current best practices using Context7
    context7_results = context7_search(
        f"{research_topic} best practices current implementation"
    )
    
    # Cross-validate findings
    validation_results = []
    for finding in web_findings:
        context7_validation = validate_against_current_practices(
            finding, context7_results
        )
        validation_results.append({
            "finding": finding,
            "current_practice_alignment": context7_validation.alignment_score,
            "implementation_examples": context7_validation.examples
        })
    
    return validation_results
```

## Success Metrics

- **Research Efficiency**: Time to complete research vs. quality of findings
- **Information Accuracy**: % of findings validated by subsequent investigation
- **Source Quality**: Average authority score of sources used
- **Completeness**: % of research criteria fully addressed
- **Actionability**: % of research that leads to concrete decisions/actions

## Integration with Other Workflows

### Evidence-Based Decision Workflow
- Web research provides evidence for decision-making
- Research validation aligns with evidence quality requirements
- Documentation supports decision audit trails

### Debugging Workflow
- Research solutions for complex technical problems
- Validate debugging approaches against industry practices
- Find similar issues and proven solutions

### Development Workflow
- Research best practices for new technologies
- Validate architectural decisions with current trends
- Find implementation examples and patterns

---

**Remember**: Research without validation is just information. Research with validation is knowledge.