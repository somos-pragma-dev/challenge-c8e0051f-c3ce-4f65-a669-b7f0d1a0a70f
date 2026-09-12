# AGENTS.md

Instrucciones para el agente de IA que abra este repositorio (Claude Code, Cursor, Codex, Copilot, Gemini). Se cargan solas: no hay que pegar nada en ningun chat.

## Que es este repositorio

Es el codigo base de un reto de aprendizaje de Pragma: **Diseño y despliegue de la infraestructura del servicio de notificaciones en Azure**.

| | |
|---|---|
| Tema | Infraestructura del servicio de notificaciones |
| Nivel | senior-l2 |
| Chapter | Cloud Ops |
| Especialidad | Azure |
| Stack | HCL / Terraform |
| Patron arquitectonico | modular con landing zone y gobierno multi-cuenta |
| Tiempo estimado | 2 semanas |

## Tu tarea

Dejar este proyecto en estado **verificable**: que el comando de verificacion corra sin errores. Escribi los archivos en disco, en este repositorio. No generes ZIPs ni archivos adjuntos.

En orden:

1. Corre `terraform init -backend=false && terraform validate && terraform fmt -check` y mira que falla.
2. Completa lo que falte de la lista de abajo: manifiesto de dependencias, punto de entrada, capa de interfaz y las capas del patron declarado.
3. Arregla SOLO los errores que impiden compilar o arrancar.
4. Volve a correr `terraform init -backend=false && terraform validate && terraform fmt -check` hasta que pase.
5. Pará ahí.

## Regla dura: las fases son trabajo del humano

**PROHIBIDO implementar los entregables de las fases.** El valor del reto esta en que la persona los resuelva. Tu trabajo es que tenga un proyecto que arranca; el hueco pedagogico se queda como esta.

No resuelvas nada de esto:

- **Fase 1 — Análisis de Requisitos y Restricciones**: Documento de requisitos y restricciones del servicio de notificaciones en Azure.
- **Fase 2 — Diseño de la Arquitectura**: Documento de arquitectura del servicio de notificaciones en Azure, incluyendo decisiones de diseño y trade-offs.
- **Fase 3 — Despliegue y Validación**: Infraestructura del servicio de notificaciones desplegada en Azure y documentada, incluyendo resultados de pruebas y ajustes realizados.

Distincion operativa:

- **Arreglar** (si): import faltante, tipo que no existe, dependencia sin declarar, error de sintaxis, archivo referenciado que no existe.
- **No tocar** (no): logica de negocio incompleta, validaciones ausentes, secretos hardcodeados, APIs deprecadas que funcionan, concurrencia insegura, patrones mejorables. Eso es lo que la persona tiene que encontrar.

## Lo que falta y tenes que completar

No se detectaron huecos: estan los archivos declarados, el boilerplate del stack y ninguna referencia quedo colgando. Igual corre el comando de verificacion — que los archivos existan no garantiza que compilen.

### Presentes (24)

- `providers.tf`
- `variables.tf`
- `modules/notifications/variables.tf`
- `main.tf`
- `outputs.tf`
- `backend.tf`
- `README.md`
- `modules/notifications/main.tf`
- `modules/notifications/outputs.tf`
- `modules/network/main.tf`
- `modules/security/main.tf`
- `modules/monitoring/main.tf`
- `environments/dev/terraform.tfvars`
- `environments/qa/terraform.tfvars`
- `environments/prod/terraform.tfvars`
- `docs/requisitos_y_restricciones.md`
- `docs/arquitectura.md`
- `docs/resultados_pruebas.md`
- `modules/network/variables.tf`
- `modules/network/outputs.tf`
- `modules/security/variables.tf`
- `modules/security/outputs.tf`
- `modules/monitoring/variables.tf`
- `modules/monitoring/outputs.tf`

### Capas del patron declarado

Cada una tiene que existir como directorio real con al menos un archivo. Codigo plano en la raiz no satisface el patron.

- `modules/notifications`
- `modules/network`
- `modules/security`
- `modules/monitoring`
- `environments/dev`
- `environments/qa`
- `environments/prod`

## Verificacion

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando pasando es la definicion de "terminado" para vos.

## Convenciones que tenes que respetar

- Un solo ecosistema: no declares librerias de otro lenguaje ni mezcles gestores de paquetes.
- Toda libreria que uses tiene que estar declarada en el manifiesto de dependencias.
- Todo import declarado tiene que usarse; todo tipo usado tiene que existir o venir de una dependencia declarada.
- El patron es **modular con landing zone y gobierno multi-cuenta**: los contratos (interfaces, puertos) los define la capa interna y los implementa la externa, nunca al revés.
- Los archivos que crees llevan implementacion real, no stubs: sin `TODO`, sin cuerpos vacios, sin `// getters y setters`.

## Contexto del candidato

Sirve para calibrar el nivel del codigo, no para resolver las fases.

- Perfil: Chapter Cloud Ops, Especialidad Azure, Tecnología Azure, Senior
- Brecha que el reto ataca: Necesita fortalecer la practica de Azure
- Mision: Liderar la iniciativa de infraestructura del servicio de notificaciones

---

*Generado por Challenge Generator — Pragma. `README.md` tiene el enunciado completo del reto para la persona. `PROMPT_MEJORA.md` es la variante para pegar en un chat, si se prefiere ese flujo.*
