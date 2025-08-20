#!/bin/bash

# Script para implementar guards de contexto al inicio de documentos específicos

echo "🛡️  IMPLEMENTANDO GUARDS DE CONTEXTO"
echo "===================================="

# Función para agregar guard a archivo
add_guard() {
    local file="$1"
    local guard_text="$2"
    
    # Crear archivo temporal
    temp_file=$(mktemp)
    
    # Agregar guard al inicio (después del primer ---)
    first_section=true
    while IFS= read -r line; do
        echo "$line" >> "$temp_file"
        
        # Después del primer --- agregar el guard
        if [[ "$line" == "---" && "$first_section" == true ]]; then
            echo "" >> "$temp_file"
            echo "$guard_text" >> "$temp_file"
            echo "" >> "$temp_file"
            first_section=false
        fi
    done < "$file"
    
    # Reemplazar archivo original
    mv "$temp_file" "$file"
    echo "✅ Guard agregado a: $file"
}

# GUARDS PARA ÍNDICES PRINCIPALES
add_guard "./system/PRINCIPLES.md" "**IF seeking specific principle** → START at [CLAUDE.md](../CLAUDE.md#system-navigation) for framework overview, THEN navigate here for detailed principles"

add_guard "./system/BEHAVIORS.md" "**IF seeking specific behavior** → START at [CLAUDE.md](../CLAUDE.md#system-navigation) for framework overview, THEN navigate here for detailed behaviors"

add_guard "./system/STANDARDS.md" "**IF seeking specific standard** → START at [CLAUDE.md](../CLAUDE.md#system-navigation) for framework overview, THEN navigate here for detailed standards"

add_guard "./system/PROCESSES.md" "**IF seeking specific process** → START at [CLAUDE.md](../CLAUDE.md#system-navigation) for framework overview, THEN navigate here for detailed processes"

add_guard "./system/EXAMPLES.md" "**IF seeking specific example** → START at [CLAUDE.md](../CLAUDE.md#system-navigation) for framework overview, THEN navigate here for detailed examples"

add_guard "./system/TOOLS.md" "**IF seeking specific tool** → START at [system/INDEX.md](INDEX.md) for system overview, THEN navigate here for tool details"

add_guard "./system/CHECKS.md" "**IF seeking specific check** → START at [system/INDEX.md](INDEX.md) for system overview, THEN navigate here for check details"

# GUARDS PARA DOCUMENTOS INDIVIDUALES DE PRINCIPLES
for file in ./system/principles/*.md; do
    if [[ -f "$file" ]]; then
        basename=$(basename "$file" .md)
        add_guard "$file" "**IF reading individually** → START at [PRINCIPLES.md](../PRINCIPLES.md) for context, THEN navigate to this specific principle"
    fi
done

# GUARDS PARA DOCUMENTOS INDIVIDUALES DE BEHAVIORS  
for file in ./system/behaviors/*.md; do
    if [[ -f "$file" ]]; then
        basename=$(basename "$file" .md)
        add_guard "$file" "**IF reading individually** → START at [BEHAVIORS.md](../BEHAVIORS.md) for context, THEN navigate to this specific behavior"
    fi
done

# GUARDS PARA DOCUMENTOS INDIVIDUALES DE STANDARDS
for file in ./system/standards/*.md; do
    if [[ -f "$file" ]]; then
        basename=$(basename "$file" .md)
        add_guard "$file" "**IF reading individually** → START at [STANDARDS.md](../STANDARDS.md) for context, THEN navigate to this specific standard"
    fi
done

# GUARDS PARA DOCUMENTOS INDIVIDUALES DE PROCESSES
for file in ./system/processes/*.md; do
    if [[ -f "$file" ]]; then
        basename=$(basename "$file" .md)
        add_guard "$file" "**IF reading individually** → START at [PROCESSES.md](../PROCESSES.md) for context, THEN navigate to this specific process"
    fi
done

# GUARDS PARA DOCUMENTOS INDIVIDUALES DE EXAMPLES
for file in ./system/examples/*.md; do
    if [[ -f "$file" ]]; then
        basename=$(basename "$file" .md)
        add_guard "$file" "**IF reading individually** → START at [EXAMPLES.md](../EXAMPLES.md) for context, THEN navigate to this specific example"
    fi
done

# GUARDS PARA TOOLS Y CHECKS INDIVIDUALES
for file in ./system/tools/*.md ./system/checks/*.md; do
    if [[ -f "$file" ]]; then
        dir=$(dirname "$file")
        if [[ "$dir" =~ tools ]]; then
            add_guard "$file" "**IF reading individually** → START at [TOOLS.md](../TOOLS.md) for context, THEN navigate to this specific tool"
        else
            add_guard "$file" "**IF reading individually** → START at [CHECKS.md](../CHECKS.md) for context, THEN navigate to this specific check"
        fi
    fi
done

# GUARDS PARA TEMPLATES
for file in ./system/templates/*.md; do
    if [[ -f "$file" ]]; then
        add_guard "$file" "**IF using this template** → START at [INDEX.md](../INDEX.md#system-structure) for framework context, THEN apply this template"
    fi
done

# GUARDS PARA COMANDOS
for file in ./commands/*.md; do
    if [[ -f "$file" ]]; then
        add_guard "$file" "**IF executing this command** → ENSURE you understand [CLAUDE.md](../CLAUDE.md) framework context, THEN execute this command"
    fi
done

echo ""
echo "✅ GUARDS DE CONTEXTO IMPLEMENTADOS"
echo "==================================="
echo "Todos los documentos específicos ahora tienen guards dirigiendo al contexto apropiado"