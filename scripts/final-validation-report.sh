#!/bin/bash

# Script para generar reporte final de validación completa

echo "📋 REPORTE FINAL DE VALIDACIÓN"
echo "=============================="
echo ""

# Ejecutar todas las validaciones
echo "🔍 EJECUTANDO VALIDACIONES COMPLETAS..."
echo ""

echo "1️⃣ VALIDACIÓN DE NAVEGACIÓN LIMPIA"
echo "=================================="
./scripts/validate-navigation-cleanup.sh | tail -7
echo ""

echo "2️⃣ VALIDACIÓN DE GUARDS DE CONTEXTO"
echo "==================================="
./scripts/validate-context-guards.sh | tail -7
echo ""

echo "3️⃣ VALIDACIÓN DE SINTAXIS IF-THEN"
echo "================================="
./scripts/validate-if-then-syntax.sh | tail -7
echo ""

echo "📊 RESUMEN EJECUTIVO"
echo "==================="

# Contadores finales
nav_issues=$(./scripts/validate-navigation-cleanup.sh | grep "Problemas encontrados:" | cut -d: -f2 | tr -d ' ')
guard_missing=$(./scripts/validate-context-guards.sh | grep "Archivos sin guards:" | cut -d: -f2 | tr -d ' ')
syntax_invalid=$(./scripts/validate-if-then-syntax.sh | grep "IF statements inválidos:" | cut -d: -f2 | tr -d ' ')

echo "• Problemas de navegación legacy: $nav_issues"
echo "• Documentos sin guards apropiados: $guard_missing"  
echo "• IF statements con sintaxis inválida: $syntax_invalid"

total_issues=$((nav_issues + guard_missing + syntax_invalid))

echo ""
if [ $total_issues -eq 0 ]; then
    echo "🎉 SISTEMA COMPLETAMENTE VALIDADO"
    echo "================================="
    echo "✅ Navegación completamente limpia (sin headers/footers legacy)"
    echo "✅ Todos los documentos tienen guards contextuales apropiados"  
    echo "✅ Toda la sintaxis IF-THEN es válida con anchors específicos"
    echo "✅ Sistema ready para implementación frontend"
else
    echo "⚠️  SE REQUIEREN $total_issues CORRECCIONES"
    echo "========================================="
fi

echo ""
echo "🛠️ SCRIPTS DE VALIDACIÓN DISPONIBLES"
echo "===================================="
echo "• validate-navigation-cleanup.sh - Verifica navegación limpia"
echo "• validate-context-guards.sh - Valida guards de contexto"
echo "• validate-if-then-syntax.sh - Verifica sintaxis IF-THEN"
echo "• final-validation-report.sh - Este reporte completo"

echo ""
echo "📁 ESTRUCTURA IMPLEMENTADA"
echo "========================="
echo "• Frontend-first navigation (sin navegación en markdown)"
echo "• Guards contextuales IF-THEN en 100 documentos específicos" 
echo "• Enlaces inline con anchors específicos"
echo "• Sistema de cross-references condicionales"
echo ""
echo "Fecha de validación: $(date)"