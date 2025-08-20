#!/bin/bash

# Script para validar sintaxis IF-THEN en todos los documentos

echo "🔍 VALIDANDO SINTAXIS IF-THEN"
echo "=============================="

# Contadores
TOTAL_IF_STATEMENTS=0
VALID_IF_STATEMENTS=0
INVALID_IF_STATEMENTS=0
FILES_WITH_IF=0
TOTAL_FILES=0

# Función para reportar problema
report_issue() {
    local file="$1"
    local issue="$2" 
    local line_num="$3"
    local line_content="$4"
    echo "❌ $file:$line_num"
    echo "   Problema: $issue"
    echo "   Línea: $line_content"
    echo ""
    ((INVALID_IF_STATEMENTS++))
}

# Función para validar sintaxis IF-THEN
validate_if_then() {
    local file="$1"
    local has_if_statements=false
    
    while IFS= read -r -u 3 line_content; do
        local line_num=$((line_num + 1))
        
        # Buscar líneas que empiecen con **IF
        if [[ "$line_content" =~ ^\*\*IF ]]; then
            ((TOTAL_IF_STATEMENTS++))
            has_if_statements=true
            
            # Validar estructura completa: **IF [condición]** → READ [link](path#anchor)
            if [[ "$line_content" =~ ^\*\*IF\ [^*]+\*\*\ →\ READ\ \[.*\]\(.*#.*\) ]]; then
                ((VALID_IF_STATEMENTS++))
                echo "✅ $file:$line_num - Sintaxis IF-THEN válida"
            else
                # Verificar patrones comunes de error
                if [[ "$line_content" =~ ^\*\*IF.*\*\*.*→ ]]; then
                    if [[ ! "$line_content" =~ READ ]]; then
                        report_issue "$file" "Falta 'READ' después de →" "$line_num" "$line_content"
                    elif [[ ! "$line_content" =~ \[.*\]\(.*#.*\) ]]; then
                        report_issue "$file" "Enlace sin anchor específico (#section)" "$line_num" "$line_content"
                    else
                        report_issue "$file" "Sintaxis IF-THEN malformada" "$line_num" "$line_content"
                    fi
                else
                    report_issue "$file" "Estructura IF-THEN incorrecta" "$line_num" "$line_content"
                fi
            fi
        fi
    done 3< "$file"
    
    if [[ "$has_if_statements" == true ]]; then
        ((FILES_WITH_IF++))
    fi
}

echo "🔍 Analizando archivos markdown..."
echo ""

# Procesar todos los archivos markdown del sistema
while IFS= read -r -d '' file; do
    ((TOTAL_FILES++))
    line_num=0
    validate_if_then "$file"
done < <(find ./system -name "*.md" -type f -print0)

# Procesar también comandos y CLAUDE.local.md
for file in ./commands/*.md ./CLAUDE.local.md; do
    if [[ -f "$file" ]]; then
        ((TOTAL_FILES++))
        line_num=0
        validate_if_then "$file"
    fi
done

echo ""
echo "📊 RESUMEN DE VALIDACIÓN IF-THEN"
echo "================================="
echo "Archivos analizados: $TOTAL_FILES"
echo "Archivos con IF statements: $FILES_WITH_IF"
echo "Total IF statements encontrados: $TOTAL_IF_STATEMENTS"
echo "IF statements válidos: $VALID_IF_STATEMENTS"
echo "IF statements inválidos: $INVALID_IF_STATEMENTS"

if [ $INVALID_IF_STATEMENTS -eq 0 ] && [ $TOTAL_IF_STATEMENTS -gt 0 ]; then
    echo ""
    echo "✅ TODA LA SINTAXIS IF-THEN ES VÁLIDA"
    echo "====================================="
elif [ $TOTAL_IF_STATEMENTS -eq 0 ]; then
    echo ""
    echo "⚠️  NO SE ENCONTRARON IF STATEMENTS"
    echo "=================================="
else
    echo ""
    echo "⚠️  SE REQUIEREN CORRECCIONES DE SINTAXIS"
    echo "========================================="
fi

echo ""
echo "🎯 PATRÓN VÁLIDO:"
echo "**IF [condición específica]** → READ [descripción](archivo.md#sección-específica)"