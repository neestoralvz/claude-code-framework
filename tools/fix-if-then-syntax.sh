#!/bin/bash

# Script para corregir sintaxis IF-THEN a formato válido

echo "🔧 CORRIGIENDO SINTAXIS IF-THEN"
echo "==============================="

# Función para corregir sintaxis en un archivo
fix_if_then_syntax() {
    local file="$1"
    local temp_file=$(mktemp)
    
    while IFS= read -r line; do
        # Corregir patrón: **IF xxx** → START at [link] for yyy, THEN zzz
        # A: **IF xxx** → READ [link] 
        if [[ "$line" =~ ^\*\*IF\ (.+)\*\*\ →\ START\ at\ \[(.+)\]\((.+)\)\ for\ (.+),\ THEN\ (.+) ]]; then
            condition="${BASH_REMATCH[1]}"
            link_text="${BASH_REMATCH[2]}"
            link_url="${BASH_REMATCH[3]}"
            context="${BASH_REMATCH[4]}"
            action="${BASH_REMATCH[5]}"
            
            # Convertir a formato correcto
            echo "**IF $condition** → READ [$link_text]($link_url) for $context, THEN $action" >> "$temp_file"
            echo "✅ Corregido: $file"
        
        # Corregir patrón: **IF xxx** → ENSURE yyy, THEN zzz  
        elif [[ "$line" =~ ^\*\*IF\ (.+)\*\*\ →\ ENSURE\ (.+),\ THEN\ (.+) ]]; then
            condition="${BASH_REMATCH[1]}"
            ensure_text="${BASH_REMATCH[2]}"
            action="${BASH_REMATCH[3]}"
            
            # Extraer link del ensure_text si existe
            if [[ "$ensure_text" =~ \[(.+)\]\((.+)\) ]]; then
                link_text="${BASH_REMATCH[1]}"
                link_url="${BASH_REMATCH[2]}"
                echo "**IF $condition** → READ [$link_text]($link_url), THEN $action" >> "$temp_file"
            else
                echo "**IF $condition** → ENSURE $ensure_text, THEN $action" >> "$temp_file"
            fi
            echo "✅ Corregido: $file"
            
        else
            # Mantener línea sin cambios
            echo "$line" >> "$temp_file"
        fi
    done < "$file"
    
    # Reemplazar archivo original
    mv "$temp_file" "$file"
}

# Procesar todos los archivos que tienen guards
while IFS= read -r -d '' file; do
    if grep -q "^\*\*IF " "$file"; then
        fix_if_then_syntax "$file"
    fi
done < <(find ./system ./commands -name "*.md" -type f -print0)

# Procesar CLAUDE.local.md
if [[ -f "./CLAUDE.local.md" ]] && grep -q "^\*\*IF " "./CLAUDE.local.md"; then
    fix_if_then_syntax "./CLAUDE.local.md"
fi

echo ""
echo "✅ SINTAXIS IF-THEN CORREGIDA"
echo "============================="