# Diseño y despliegue de la infraestructura del servicio de notificaciones en Azure

El servicio de notificaciones es un componente crítico para la comunicación entre diferentes partes del sistema y los usuarios. Debe ser escalable, seguro y capaz de manejar un alto volumen de notificaciones en tiempo real. El objetivo es diseñar y desplegar la infraestructura necesaria en Azure para soportar este servicio, considerando las mejores prácticas de Azure y asegurando la robustez y eficiencia del sistema.

## Informacion General

| Campo | Valor |
|-------|-------|
| **Tema** | Infraestructura del servicio de notificaciones |
| **Nivel** | senior-l2 |
| **Tipo** | practical |
| **Tiempo estimado** | 2 semanas |

## Fases del Reto

### Fase 0: Configuración del Proyecto

**Objetivo:** Obtener el proyecto base funcional enviando el Código Base a un asistente de IA, que lo analizará, corregirá errores y generará un ZIP listo para usar.

**Tiempo estimado:** 15-30 minutos

**Instrucciones:**

- Asegúrate de tener instalado para ejecutar el proyecto: Un IDE o editor de código.
- Copia todo el contenido del campo **Código Base** de este reto — incluyendo el texto de instrucciones que aparece al inicio.
- Abre un asistente de IA (Claude en claude.ai, ChatGPT o Gemini — se recomienda Claude), pega el contenido copiado en el chat y envíalo.
- El asistente analizará los archivos, corregirá errores y generará un archivo ZIP descargable. Descárgalo y extráelo en la carpeta donde quieras trabajar.
- Verifica que el proyecto arranca sin errores.

**Entregable:** El proyecto compila/arranca sin errores.

<details>
<summary>Pistas de conocimiento</summary>

- Copia el Código Base completo incluyendo el texto de instrucciones al inicio — esas instrucciones le indican al asistente exactamente qué hacer con los archivos.
- Si el asistente no genera el ZIP automáticamente al terminar el análisis, escríbele: "genera el ZIP ahora".
- Si el proyecto tiene errores al arrancar, comparte el mensaje de error con el mismo asistente para que lo corrija.

</details>

### Fase 1: Análisis de Requisitos y Restricciones

**Objetivo:** Identificar y documentar los requisitos funcionales y no funcionales del servicio de notificaciones, así como las restricciones y consideraciones de diseño.

**Tiempo estimado:** 3 días

**Instrucciones:**

- Enumerar los actores involucrados (ej. usuarios, servicios internos, proveedores externos) y sus interacciones con el servicio de notificaciones.
- Identificar los umbrales numéricos del dominio (ej. volumen de notificaciones por segundo, latencia aceptable).
- Documentar las restricciones del dominio (ej. SLAs, compliance con regulaciones).

**Entregable:** Documento de requisitos y restricciones del servicio de notificaciones en Azure.

<details>
<summary>Pistas de conocimiento</summary>

- Considerar la escalabilidad y la alta disponibilidad como requisitos clave.
- Investigar las mejores prácticas de Azure para servicios de notificación.

</details>

### Fase 2: Diseño de la Arquitectura

**Objetivo:** Diseñar la arquitectura del servicio de notificaciones en Azure, considerando las decisiones de diseño y los trade-offs.

**Tiempo estimado:** 5 días

**Instrucciones:**

- Proponer una arquitectura que cumpla con los requisitos y restricciones identificados en la fase anterior.
- Evaluar diferentes opciones de servicios de Azure (ej. Azure Functions, Azure Service Bus, Azure Notification Hubs) y seleccionar la combinación óptima.
- Documentar las decisiones de diseño y los trade-offs considerados.

**Entregable:** Documento de arquitectura del servicio de notificaciones en Azure, incluyendo decisiones de diseño y trade-offs.

<details>
<summary>Pistas de conocimiento</summary>

- Considerar la latencia, el throughput, y la fault tolerance en la selección de servicios.
- Evaluar la integración con otros servicios de Azure y la facilidad de mantenimiento.

</details>

### Fase 3: Despliegue y Validación

**Objetivo:** Desplegar la infraestructura diseñada y validar que cumple con los requisitos y restricciones.

**Tiempo estimado:** 4 días

**Instrucciones:**

- Implementar la infraestructura del servicio de notificaciones en Azure siguiendo el diseño propuesto.
- Realizar pruebas de carga y rendimiento para validar que la infraestructura cumple con los requisitos de escalabilidad y latencia.
- Documentar los resultados de las pruebas y cualquier ajuste realizado.

**Entregable:** Infraestructura del servicio de notificaciones desplegada en Azure y documentada, incluyendo resultados de pruebas y ajustes realizados.

<details>
<summary>Pistas de conocimiento</summary>

- Utilizar herramientas de Azure para monitorear y ajustar el rendimiento del servicio.
- Considerar la automatización del despliegue para futuras iteraciones.

</details>

## Dimensiones Evaluadas

- **queEs**: ¿Qué es el servicio de notificaciones y cuál es su propósito en el sistema?
- **paraQueSirve**: ¿Para qué sirve la infraestructura diseñada en Azure y cómo soporta las operaciones del servicio de notificaciones?
- **comoSeUsa**: ¿Cómo se usa la infraestructura del servicio de notificaciones en Azure para enviar notificaciones a los usuarios?
- **erroresComunes**: ¿Cuáles son los errores comunes que pueden ocurrir en el despliegue y operación del servicio de notificaciones en Azure y cómo se pueden mitigar?
- **queDecisionesImplica**: ¿Qué decisiones de diseño implica el despliegue del servicio de notificaciones en Azure y cuáles fueron los trade-offs considerados?

## Criterios de Evaluacion

- Documento de requisitos y restricciones del servicio de notificaciones en Azure.
- Documento de arquitectura del servicio de notificaciones en Azure, incluyendo decisiones de diseño y trade-offs.
- Infraestructura del servicio de notificaciones desplegada en Azure y documentada, incluyendo resultados de pruebas y ajustes realizados.

## Como trabajar con un asistente de IA

Hay dos caminos, elegi uno:

- **AGENTS.md** (recomendado) — instrucciones nativas del repo. Abri esta carpeta con tu agente local (Claude Code, Cursor, Codex, Copilot, Gemini) y las carga solo. Sabe que archivos faltan y con que comando se verifica, y completa el scaffold escribiendo en disco.
- **PROMPT_MEJORA.md** — para copiar y pegar en un chat (claude.ai, ChatGPT). Devuelve un ZIP con el proyecto. Sirve si no tenes un agente en el IDE.

Ninguno de los dos resuelve las fases del reto: eso es tu trabajo.

## Verificacion

El proyecto esta listo para trabajar cuando este comando corre sin errores:

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

---

*Reto generado automaticamente por Challenge Generator - Pragma*
