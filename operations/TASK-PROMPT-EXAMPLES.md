# Task Prompt Examples

## Example 1: API Development

```
Task(subagent_type: 'api-design-specialist', description: 'create-user-api', prompt: 'Yo soy el orquestador y tu eres el agente api-design-specialist.

CONTEXTO: Sistema de gestión de usuarios sin autenticación implementada, base de datos PostgreSQL configurada, framework Express.js en uso

LEER:
- User model: src/models/User.js - estructura de datos
- API patterns: docs/api-conventions.md - estándares del proyecto
- Database schema: db/migrations/001_users.sql - esquema actual

OBJETIVO: Crear API REST completa para gestión de usuarios con autenticación JWT

TAREAS:
1. Implementar endpoints CRUD para usuarios
2. Agregar middleware de autenticación JWT
3. Crear validación de datos de entrada

ÉXITO:
- Todos los endpoints responden correctamente
- Autenticación JWT funcional
- Validación completa implementada

MEDIDAS:
- 6 endpoints funcionando (POST, GET, PUT, DELETE, LOGIN, REFRESH)
- Tests con 100% de cobertura
- Tiempo de respuesta < 200ms

HACER:
1. Crear controladores de usuario en src/controllers/
2. Implementar middleware JWT en src/middleware/
3. Configurar rutas en src/routes/users.js
4. Escribir tests en tests/users.test.js

ENTREGAR:
1. User Controller: funciones CRUD completas → src/controllers/userController.js
2. JWT Middleware: autenticación y autorización → src/middleware/auth.js
3. User Routes: rutas RESTful → src/routes/users.js
4. Test Suite: cobertura 100% → tests/users.test.js

VALIDAR:
□ Todos los tests pasan
□ Endpoints responden según especificación
□ JWT tokens válidos generados

CALCULAR:
- Coverage: líneas cubiertas / líneas totales * 100
- Response time: tiempo promedio de 10 requests
- Success rate: requests exitosos / total requests * 100

REPETIR: Si no 100% → reiniciar desde HACER. Máximo 5 veces.')
```

## Example 2: Code Quality Review

```
Task(subagent_type: 'code-quality-specialist', description: 'review-payment-module', prompt: 'Yo soy el orquestador y tu eres el agente code-quality-specialist.

CONTEXTO: Módulo de pagos recién desarrollado, requiere revisión antes de producción, equipo reporta bugs intermitentes

LEER:
- Payment module: src/payments/ - código a revisar
- Coding standards: docs/standards.md - estándares del proyecto
- Test results: tests/reports/latest.html - resultados actuales

OBJETIVO: Asegurar calidad del código del módulo de pagos para producción

TAREAS:
1. Revisar código contra estándares establecidos
2. Identificar vulnerabilidades de seguridad
3. Validar cobertura de tests y calidad

ÉXITO:
- Sin vulnerabilidades críticas
- Cumple 100% estándares de código
- Cobertura de tests > 95%

MEDIDAS:
- 0 issues críticos en SonarQube
- Puntuación A en CodeClimate
- 95%+ cobertura de líneas y ramas

HACER:
1. Ejecutar análisis estático con SonarQube
2. Revisar manualmente lógica de negocio
3. Validar tests existentes y agregar faltantes
4. Verificar manejo de errores y logging

ENTREGAR:
1. Security Report: vulnerabilidades encontradas → reports/security-audit.md
2. Quality Report: métricas y recomendaciones → reports/quality-review.md
3. Test Improvements: tests adicionales → tests/payments/
4. Code Fixes: correcciones aplicadas → src/payments/

VALIDAR:
□ SonarQube gate passed
□ Todos los tests pasan
□ Manual review completado

CALCULAR:
- Security score: vulnerabilidades resueltas / total * 100
- Quality gate: métricas que pasan / total métricas * 100
- Test coverage: líneas cubiertas / líneas totales * 100

REPETIR: Si no 100% → reiniciar desde HACER. Máximo 5 veces.')
```

## Example 3: System Dashboard

```
Task(subagent_type: 'dashboard-management-specialist', description: 'create-monitoring-dashboard', prompt: 'Yo soy el orquestador y tu eres el agente dashboard-management-specialist.

CONTEXTO: Sistema distribuido sin visibilidad centralizada, múltiples servicios corriendo, necesidad de monitoreo en tiempo real

LEER:
- Service registry: config/services.json - servicios activos
- Metrics config: monitoring/metrics.yml - métricas disponibles
- UI guidelines: docs/ui-standards.md - estándares de interfaz

OBJETIVO: Crear dashboard centralizado para monitoreo de sistema distribuido

TAREAS:
1. Diseñar interfaz de dashboard con métricas clave
2. Implementar conexiones a fuentes de datos
3. Configurar alertas y notificaciones

ÉXITO:
- Dashboard muestra métricas en tiempo real
- Alertas configuradas y funcionando
- Interfaz responsive y usable

MEDIDAS:
- 15+ métricas visualizadas correctamente
- Tiempo de carga < 3 segundos
- 100% uptime de dashboard

HACER:
1. Crear componentes de visualización en React
2. Configurar WebSocket para datos en tiempo real
3. Implementar sistema de alertas
4. Diseñar layout responsive

ENTREGAR:
1. Dashboard UI: interfaz completa → src/dashboard/components/
2. Data connectors: conexiones a servicios → src/dashboard/connectors/
3. Alert system: configuración de alertas → src/dashboard/alerts/
4. Documentation: guía de uso → docs/dashboard-guide.md

VALIDAR:
□ Todas las métricas se actualizan
□ Alertas se disparan correctamente
□ Dashboard responsive en móvil/desktop

CALCULAR:
- Metric accuracy: métricas correctas / total métricas * 100
- Load time: tiempo promedio de carga inicial
- Alert reliability: alertas enviadas / eventos críticos * 100

REPETIR: Si no 100% → reiniciar desde HACER. Máximo 5 veces.')
```