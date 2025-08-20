#!/bin/bash

# Script para validar que todos los documentos tienen los guards de contexto apropiados

echo "🛡️  VALIDANDO GUARDS DE CONTEXTO"
echo "================================="

# Contadores
TOTAL_FILES=0
FILES_WITH_GUARDS=0
FILES_WITHOUT_GUARDS=0
ENTRY_POINTS=0

# Función para verificar si un archivo debería tener guard
should_have_guard() {
    local file="$1"
    local basename=$(basename "$file" .md)
    local dirname=$(dirname "$file")
    
    # Archivos que NO necesitan guards (puntos de entrada)
    if [[ "$basename" =~ ^(INDEX|CLAUDE|README)$ ]]; then
        return 1  # No debería tener guard
    fi
    
    # Archivos de operaciones históricas no necesitan guards
    if [[ "$dirname" =~ operations/ ]]; then
        return 1  # No debería tener guard
    fi
    
    # Agents no necesitan guards por ahora
    if [[ "$dirname" =~ agents/ ]]; then
        return 1  # No debería tener guard
    fi
    
    # Scripts no necesitan guards
    if [[ "$dirname" =~ scripts/ ]]; then
        return 1  # No debería tener guard
    fi
    
    # Dashboard no necesita guards
    if [[ "$dirname" =~ dashboard/ ]]; then
        return 1  # No debería tener guard
    fi
    
    return 0  # Debería tener guard
}

# Función para verificar si un archivo tiene guard
has_guard() {
    local file="$1"
    # Buscar patrón IF en las primeras 10 líneas
    if head -10 "$file" | grep -q "^\*\*IF "; then
        return 0  # Tiene guard
    fi
    return 1  # No tiene guard
}

echo "🔍 Analizando archivos markdown..."
echo ""

# Procesar todos los archivos markdown
while IFS= read -r -d '' file; do
    ((TOTAL_FILES++))
    
    if should_have_guard "$file"; then
        if has_guard "$file"; then
            ((FILES_WITH_GUARDS++))
            echo "✅ $file - Guard presente"
        else
            ((FILES_WITHOUT_GUARDS++))
            echo "❌ $file - Guard FALTANTE"
        fi
    else
        ((ENTRY_POINTS++))
        echo "ℹ️  $file - Entry point (no requiere guard)"
    fi
    
done < <(find . -name "*.md" -type f -print0 | head -20)

echo ""
echo "📊 RESUMEN DE VALIDACIÓN"
echo "========================"
echo "Total archivos analizados: $TOTAL_FILES"
echo "Entry points (sin guard): $ENTRY_POINTS"
echo "Archivos con guards: $FILES_WITH_GUARDS"
echo "Archivos sin guards: $FILES_WITHOUT_GUARDS"

if [ $FILES_WITHOUT_GUARDS -eq 0 ]; then
    echo ""
    echo "✅ TODOS LOS DOCUMENTOS TIENEN GUARDS APROPIADOS"
    echo "================================================"
else
    echo ""
    echo "⚠️  ALGUNOS DOCUMENTOS REQUIEREN GUARDS"
    echo "======================================="
fi

echo ""
echo "🎯 EJEMPLO DE GUARD VÁLIDO:"
echo "**IF seeking specific principle** → START at [CLAUDE.md](../CLAUDE.md#system-navigation) for framework overview, THEN navigate here for detailed principles"