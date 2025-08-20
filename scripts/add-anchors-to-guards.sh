#!/bin/bash

# Script para agregar anchors específicos a los guards IF-THEN

echo "🔗 AGREGANDO ANCHORS ESPECÍFICOS A GUARDS"
echo "=========================================="

# Función para agregar anchors a guards
add_anchors_to_guards() {
    local file="$1"
    local temp_file=$(mktemp)
    
    while IFS= read -r line; do
        # Procesar líneas IF-THEN que necesitan anchors
        if [[ "$line" =~ ^\*\*IF\ (.+)\*\*\ →\ READ\ \[(.+)\]\((.+)\)\ for\ (.+),\ THEN\ (.+) ]]; then
            condition="${BASH_REMATCH[1]}"
            link_text="${BASH_REMATCH[2]}" 
            link_url="${BASH_REMATCH[3]}"
            context="${BASH_REMATCH[4]}"
            action="${BASH_REMATCH[5]}"
            
            # Determinar anchor apropiado basado en el archivo
            anchor=""
            if [[ "$link_url" =~ CLAUDE\.md ]]; then
                anchor="#system-navigation"
            elif [[ "$link_url" =~ INDEX\.md ]]; then
                anchor="#system-structure"
            elif [[ "$link_url" =~ PRINCIPLES\.md ]]; then
                anchor="#work-approach"
            elif [[ "$link_url" =~ BEHAVIORS\.md ]]; then
                anchor="#communication-style"
            elif [[ "$link_url" =~ STANDARDS\.md ]]; then
                anchor="#technical-standards"
            elif [[ "$link_url" =~ PROCESSES\.md ]]; then
                anchor="#workflow-processes"
            elif [[ "$link_url" =~ EXAMPLES\.md ]]; then
                anchor="#implementation-examples"
            elif [[ "$link_url" =~ TOOLS\.md ]]; then
                anchor="#system-tools"
            elif [[ "$link_url" =~ CHECKS\.md ]]; then
                anchor="#quality-checks"
            fi
            
            # Agregar anchor si no existe
            if [[ -n "$anchor" && ! "$link_url" =~ "#" ]]; then
                echo "**IF $condition** → READ [$link_text](${link_url}${anchor}) for $context, THEN $action" >> "$temp_file"
                echo "✅ Anchor agregado: $file -> $link_url$anchor"
            else
                echo "$line" >> "$temp_file"
            fi
            
        # Procesar líneas IF-THEN simples que necesitan anchors
        elif [[ "$line" =~ ^\*\*IF\ (.+)\*\*\ →\ READ\ \[(.+)\]\((.+)\),\ THEN\ (.+) ]]; then
            condition="${BASH_REMATCH[1]}"
            link_text="${BASH_REMATCH[2]}"
            link_url="${BASH_REMATCH[3]}"
            action="${BASH_REMATCH[4]}"
            
            # Determinar anchor apropiado
            anchor=""
            if [[ "$link_url" =~ CLAUDE\.md ]]; then
                anchor="#framework-overview"
            elif [[ "$link_url" =~ INDEX\.md ]]; then
                anchor="#system-structure"
            fi
            
            # Agregar anchor si no existe
            if [[ -n "$anchor" && ! "$link_url" =~ "#" ]]; then
                echo "**IF $condition** → READ [$link_text](${link_url}${anchor}), THEN $action" >> "$temp_file"
                echo "✅ Anchor agregado: $file -> $link_url$anchor"
            else
                echo "$line" >> "$temp_file"
            fi
            
        else
            echo "$line" >> "$temp_file"
        fi
    done < "$file"
    
    # Reemplazar archivo original
    mv "$temp_file" "$file"
}

# Procesar todos los archivos con guards
while IFS= read -r -d '' file; do
    if grep -q "^\*\*IF " "$file"; then
        add_anchors_to_guards "$file"
    fi
done < <(find ./system ./commands -name "*.md" -type f -print0)

# Procesar CLAUDE.local.md
if [[ -f "./CLAUDE.local.md" ]] && grep -q "^\*\*IF " "./CLAUDE.local.md"; then
    add_anchors_to_guards "./CLAUDE.local.md"
fi

echo ""
echo "✅ ANCHORS ESPECÍFICOS AGREGADOS"
echo "==============================="