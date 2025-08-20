#!/bin/bash

# Script para validar la limpieza completa de navegación en archivos markdown

echo "🔍 VALIDANDO LIMPIEZA DE NAVEGACIÓN"
echo "=================================="

# Contadores
ISSUES=0
TOTAL_FILES=0

# Función para reportar problema
report_issue() {
    local file="$1"
    local issue="$2" 
    local line="$3"
    echo "❌ $file: $issue"
    if [ -n "$line" ]; then
        echo "   Línea: $line"
    fi
    ((ISSUES++))
}

# Buscar archivos markdown
while IFS= read -r -d '' file; do
    ((TOTAL_FILES++))
    
    # Verificar headers de navegación legacy
    if grep -q "🏠 System Hub" "$file"; then
        report_issue "$file" "Header de navegación legacy encontrado"
    fi
    
    # Verificar footers de navegación legacy
    if grep -q "^\*\*Navigation:\*\*" "$file"; then
        report_issue "$file" "Footer de navegación legacy encontrado"
    fi
    
    # Verificar breadcrumbs legacy
    if grep -q "›" "$file"; then
        line=$(grep -n "›" "$file" | head -1)
        report_issue "$file" "Breadcrumb legacy encontrado" "$line"
    fi
    
    # Verificar enlaces sin anchors específicos (excepto INDEX principal)
    if [[ ! "$file" =~ INDEX\.md$ ]] && [[ ! "$file" =~ CLAUDE\.md$ ]]; then
        while IFS= read -r line; do
            if echo "$line" | grep -q '\[.*\](.*\.md)$' && ! echo "$line" | grep -q '\[.*\](.*\.md#'; then
                report_issue "$file" "Enlace sin anchor específico encontrado" "$line"
            fi
        done < "$file"
    fi
    
done < <(find . -name "*.md" -type f -print0)

echo ""
echo "📊 RESUMEN DE VALIDACIÓN"
echo "======================="
echo "Archivos analizados: $TOTAL_FILES"
echo "Problemas encontrados: $ISSUES"

if [ $ISSUES -eq 0 ]; then
    echo "✅ NAVEGACIÓN COMPLETAMENTE LIMPIA"
else
    echo "⚠️  SE REQUIERE LIMPIEZA ADICIONAL"
fi

echo ""