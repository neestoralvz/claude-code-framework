#!/bin/bash

# Script para analizar qué documentos requieren contexto específico antes de ser leídos

echo "🔍 ANALIZANDO REQUISITOS DE CONTEXTO"
echo "===================================="

# Función para categorizar archivos
categorize_file() {
    local file="$1"
    local basename=$(basename "$file" .md)
    local dirname=$(dirname "$file")
    
    # Archivos que NO necesitan guards (puntos de entrada)
    if [[ "$basename" =~ ^(INDEX|CLAUDE|README)$ ]]; then
        echo "ENTRY_POINT: $file"
        return
    fi
    
    # Archivos de operaciones históricas
    if [[ "$dirname" =~ operations/ ]]; then
        echo "HISTORICAL: $file"
        return
    fi
    
    # Workflows específicos
    if [[ "$basename" =~ -workflow$ ]]; then
        echo "WORKFLOW: $file"
        return
    fi
    
    # Templates
    if [[ "$dirname" =~ templates/ ]]; then
        echo "TEMPLATE: $file"
        return
    fi
    
    # Principles específicos
    if [[ "$dirname" =~ principles/ ]]; then
        echo "PRINCIPLE: $file"
        return
    fi
    
    # Behaviors específicos
    if [[ "$dirname" =~ behaviors/ ]]; then
        echo "BEHAVIOR: $file"
        return
    fi
    
    # Standards específicos
    if [[ "$dirname" =~ standards/ ]]; then
        echo "STANDARD: $file"
        return
    fi
    
    # Examples específicos
    if [[ "$dirname" =~ examples/ ]]; then
        echo "EXAMPLE: $file"
        return
    fi
    
    # Tools y checks
    if [[ "$dirname" =~ (tools|checks)/ ]]; then
        echo "UTILITY: $file"
        return
    fi
    
    # Comandos
    if [[ "$dirname" =~ commands/ ]]; then
        echo "COMMAND: $file"
        return
    fi
    
    # Agents
    if [[ "$dirname" =~ agents/ ]]; then
        echo "AGENT: $file"
        return
    fi
    
    # Default: requiere contexto
    echo "NEEDS_GUARD: $file"
}

# Contadores por categoría
declare -A CATEGORIES
TOTAL=0

# Procesar todos los archivos markdown
while IFS= read -r -d '' file; do
    ((TOTAL++))
    category=$(categorize_file "$file")
    cat_name=$(echo "$category" | cut -d: -f1)
    ((CATEGORIES[$cat_name]++))
    
    # Solo mostrar los que necesitan guards
    if [[ "$category" =~ ^NEEDS_GUARD: ]]; then
        echo "$category"
    fi
done < <(find . -name "*.md" -type f -print0)

echo ""
echo "📊 RESUMEN POR CATEGORÍAS"
echo "========================"
for category in "${!CATEGORIES[@]}"; do
    echo "$category: ${CATEGORIES[$category]} archivos"
done
echo "TOTAL: $TOTAL archivos"

echo ""
echo "📝 ESTRATEGIA DE GUARDS"
echo "======================="
echo "• ENTRY_POINT: No necesitan guards (puntos de entrada del sistema)"
echo "• HISTORICAL: Guards simples de contexto histórico"
echo "• WORKFLOW/PRINCIPLE/BEHAVIOR/STANDARD/EXAMPLE: Guards dirigiendo al índice padre"
echo "• UTILITY/COMMAND/AGENT: Guards dirigiendo al contexto de uso"
echo "• NEEDS_GUARD: Requieren análisis individual para guards específicos"