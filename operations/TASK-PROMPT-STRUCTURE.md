# Task Prompt Structure Template

## Standard Prompt Format

```
prompt: 'Yo soy el orquestador y tu eres el agente {subagent_type}. 

CONTEXTO: {descripción del estado actual, problema identificado, necesidades del usuario, restricciones del entorno}

LEER:
- {documento 1}: {ruta/archivo} - {propósito específico}
- {documento 2}: {ruta/archivo} - {propósito específico}
- {documento 3}: {ruta/archivo} - {propósito específico}

OBJETIVO: {meta principal que se busca alcanzar con esta tarea}

TAREAS:
1. {tarea específica 1 - medible y acotada}
2. {tarea específica 2 - medible y acotada}
3. {tarea específica 3 - medible y acotada}

ÉXITO:
- {criterio 1: condición específica que debe cumplirse}
- {criterio 2: condición específica que debe cumplirse}
- {criterio 3: condición específica que debe cumplirse}

MEDIDAS:
- {métrica 1: valor cuantificable o cualitativo específico}
- {métrica 2: valor cuantificable o cualitativo específico}
- {métrica 3: valor cuantificable o cualitativo específico}

HACER:
1. {paso 1 - acción específica y directa}
2. {paso 2 - acción específica y directa}
3. {paso 3 - acción específica y directa}

ENTREGAR:
1. {entregable 1}: {criterios específicos} → {ruta/archivo}
2. {entregable 2}: {criterios específicos} → {ruta/archivo}
3. {entregable 3}: {criterios específicos} → {ruta/archivo}

VALIDAR:
□ {validación 1}
□ {validación 2}
□ {validación 3}

CALCULAR:
- {cálculo 1}: {método de verificación}
- {cálculo 2}: {método de verificación}
- {cálculo 3}: {método de verificación}

REPETIR: Si no 100% → reiniciar desde HACER. Máximo 5 veces.'
```

## Usage

Use this structure for all Task tool prompts to ensure:
- Clear context and documentation requirements
- Specific objectives and success criteria
- Measurable outcomes
- Clear deliverables with file paths
- Validation processes
- Quality assurance through recursion

## Complete Task Structure

```json
{
  "description": "short-task-description",
  "prompt": "[use structure above]",
  "subagent_type": "appropriate-agent-type"
}
```