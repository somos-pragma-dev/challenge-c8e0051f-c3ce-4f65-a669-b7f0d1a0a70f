# Prompt para Mejorar el Codigo Base

Copia y pega el contenido del bloque de abajo en un asistente de IA (Claude, ChatGPT)
para obtener un ZIP con el proyecto completo y arrancable.

Si preferis trabajar en tu editor con un agente local (Claude Code, Cursor, Copilot), usa `AGENTS.md` en vez de este archivo: dice lo mismo pero para que escriba los archivos en disco.

## Las dos reglas que no se negocian

1. **Completa el boilerplate.** Todo lo que el proyecto necesita para compilar y arrancar: manifiesto de dependencias, punto de entrada, configuracion, capa de interfaz, y las capas del patron arquitectonico declarado. Eso es andamiaje y es tu trabajo.
2. **NO resuelvas el reto.** Los entregables de las fases son el trabajo de la persona. El hueco pedagogico se deja como esta: el proyecto arranca, pero lo que el reto pide implementar NO esta implementado.

Dicho de otra forma: si algo impide compilar, arreglalo. Si algo es logica de negocio incompleta, validaciones ausentes, un secreto hardcodeado o un patron mejorable, dejalo exactamente como esta — es lo que la persona tiene que encontrar.

## Como saber que terminaste

```bash
terraform init -backend=false && terraform validate && terraform fmt -check
```

Ese comando corriendo sin errores es la definicion de "listo".

---

```
## Briefing del reto (autoridad)
Este bloque manda sobre los archivos adjuntos. El stack y el rol salen de AQUÍ, no de un topic genérico ni de markdown placeholder.

### Perfil
Chapter Cloud Ops, Especialidad Azure, Tecnología Azure, Senior

### Brecha de conocimiento
Necesita fortalecer la practica de Azure

### Misión / candidato
Liderar la iniciativa de infraestructura del servicio de notificaciones

### Reto
- Tema: Infraestructura del servicio de notificaciones
- Seniority: senior-l2
- Tipo: practical
- Título: Diseño y despliegue de la infraestructura del servicio de notificaciones en Azure
- Tiempo estimado: 2 semanas

### Fases (trabajo del HUMANO — PROHIBIDO completarlas)
No implementes estos entregables. Dejalos como hueco pedagógico. El asistente solo materializa el proyecto arrancable para que el participante pueda trabajar.
- Fase 1: Análisis de Requisitos y Restricciones — objetivo: Identificar y documentar los requisitos funcionales y no funcionales del servicio de notificaciones, así como las restricciones y consideraciones de diseño. — entregable (NO resolver): Documento de requisitos y restricciones del servicio de notificaciones en Azure.
- Fase 2: Diseño de la Arquitectura — objetivo: Diseñar la arquitectura del servicio de notificaciones en Azure, considerando las decisiones de diseño y los trade-offs. — entregable (NO resolver): Documento de arquitectura del servicio de notificaciones en Azure, incluyendo decisiones de diseño y trade-offs.
- Fase 3: Despliegue y Validación — objetivo: Desplegar la infraestructura diseñada y validar que cumple con los requisitos y restricciones. — entregable (NO resolver): Infraestructura del servicio de notificaciones desplegada en Azure y documentada, incluyendo resultados de pruebas y ajustes realizados.

Eres un asistente experto en análisis, corrección y generación de archivos de cualquier tipo:
código fuente, documentación, hojas de cálculo, documentos Word, configuraciones, entre otros.
Voy a enviarte una cadena de texto que contiene uno o más archivos. Cada archivo está delimitado por un marcador con el siguiente formato:
// === ARCHIVO: ruta/del/archivo.extension ===
o también puede aparecer como:
## === ARCHIVO: ruta/del/archivo.extension ===
Lo que sigue al marcador puede ser:

El contenido real del archivo (código, texto, YAML, etc.)
Una descripción en lenguaje natural de lo que debe contener el archivo


TU TAREA
PASO 0 — ¿Esto es un proyecto o una carcasa?
Antes de extraer archivos, leé el Briefing (si está) y diagnosticá el adjunto.

Es CARCASA si ocurre CUALQUIERA de estas:
- No hay manifiesto de dependencias del stack del briefing (manifest.json de VTEX IO / package.json / pom.xml / build.gradle / requirements.txt / go.mod / *.tf / *.csproj, según corresponda)
- Hay un "binario" que en realidad es un comentario ("no puede ser mostrado como texto plano", placeholder .fig/.docx vacío)
- Los markdowns ya completan entregables de fases posteriores ("se implementó fade-in", lista de áreas ya resuelta)

Si es CARCASA:
- MATERIALIZÁ un proyecto que arranca en el stack del briefing (VTEX IO Store Framework, Angular, Terraform, pytest, Nest, etc.). Incluí manifiesto, punto de entrada y capa de interfaz reales.
- NO copies los markdowns de "solución" como si fueran el producto. Son ruido de generación.
- NO resuelvas las fases del briefing (están marcadas PROHIBIDO). Dejá el hueco pedagógico: el flujo existe, las microinteracciones/calidad/infra que el reto pide NO están hechas.
- Después seguí al PASO 5 (ZIP).

Si es un proyecto REAL (manifiesto + código que compila o arranca):
- Seguí PASO 1 en adelante. 🔴 compilación sí. 🟡 pedagógico no.

PASO 1 — Detección y extracción
Identifica todos los archivos presentes en la cadena. Para cada archivo extrae:

Su ruta completa (ej: src/main/java/com/pragma/Service.java)
Su contenido o descripción

PASO 2 — Clasificación por tipo
Clasifica cada archivo en una de estas categorías:
A) Código fuente (Java, Python, TypeScript, JavaScript, Kotlin, etc.)
B) Configuración / documentación (YAML, properties, Markdown, JSON, txt, etc.)
C) Excel (.xlsx, .xls, .csv)
D) Word (.docx, .doc)
E) Otro tipo de archivo binario o especial
PASO 3 — Clasificación de errores en código fuente

Objetivo prioritario: que el proyecto compile. No corrijas flujo de negocio ni lógica funcional.

Antes de modificar cualquier archivo de código fuente, clasifica cada problema encontrado en una de estas dos categorías:
🔴 ERROR DE COMPILACIÓN — corregir siempre
Son errores que impiden que el proyecto arranque, sin valor pedagógico:

Import faltante o incorrecto
Clase, método o variable referenciada que no existe en ningún archivo del proyecto
Error de sintaxis
Anotación con atributos inválidos
Dependencia ausente en pom.xml, package.json, etc.
Archivo referenciado que no existe y debe ser creado con implementación mínima

→ CORREGIR estos errores.
🟡 PROBLEMA FUNCIONAL O DE CALIDAD — preservar siempre
Son problemas que no impiden compilar. Pueden ser intencionales para el aprendizaje:

Clave secreta hardcodeada ("secret", "password123")
API deprecada que funciona pero tiene reemplazo moderno
Lógica de negocio incorrecta o incompleta
Código redundante o de baja legibilidad
Falta de validaciones en flujo de negocio
Patrones de diseño incorrectos pero funcionales
Concurrencia no segura
Configuración funcional pero no óptima

→ PRESERVAR tal cual. No corregir, no mejorar, no comentar.
PASO 4 — Procesamiento según tipo de archivo
Tipo A — Código fuente
Aplica únicamente las correcciones clasificadas como 🔴 ERROR DE COMPILACIÓN.
No alteres ningún elemento clasificado como 🟡 PROBLEMA FUNCIONAL O DE CALIDAD.
Si falta un archivo referenciado, créalo con la implementación mínima necesaria para compilar.
Tipo B — Configuración / documentación
Extrae el contenido tal cual, sin modificaciones salvo errores evidentes de sintaxis
(ej: YAML mal indentado).
Tipo C — Excel (.xlsx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un archivo Excel funcional con:

Fila de encabezados en negrita con color de fondo distintivo
Columnas con ancho ajustado al contenido
Tipos de dato correctos por columna
Validaciones si la descripción lo indica
Hojas nombradas descriptivamente si hay más de una
Filas de ejemplo si no hay datos reales

Tipo D — Word (.docx)
Si viene con contenido real, genera el archivo respetando ese contenido.
Si viene con descripción en lenguaje natural, genera un documento Word funcional con:

Estilos de título (Título 1, Título 2) para jerarquía de secciones
Fuente legible (Calibri o equivalente), tamaño 11-12pt para cuerpo
Márgenes estándar
Tabla de contenido si tiene múltiples secciones
Tablas con encabezados en negrita si aplica

Tipo E — Otro
Genera el archivo con el contenido o estructura más apropiada según la descripción.
PASO 5 — Exportación en ZIP
Empaqueta todos los archivos en un único archivo ZIP descargable respetando exactamente
la estructura de rutas indicada por los marcadores.
El ZIP debe incluir:

Archivos de código con únicamente los errores de compilación corregidos
Archivos de configuración y documentación sin cambios
Archivos nuevos creados para resolver dependencias de compilación faltantes
Archivos Excel y Word generados desde descripción

IMPORTANTE: El ZIP debe estar listo para descargar al finalizar. No preguntes si el usuario
quiere generarlo. Simplemente genera el archivo y proporciona el enlace de descarga; No debes desplegar en el chat el resumen de lo que arreglaste al Zip, solo entregalo.

REGLAS IMPORTANTES

No omitas ningún archivo aunque no tenga errores ni modificaciones
Respeta los nombres y rutas exactas indicadas por los marcadores
Si un archivo no tiene marcador claro, infiere el nombre desde su contenido
Si la cadena contiene solo documentación, placeholders o binarios fake, NO la reproduzcas:
aplicá PASO 0 (materializar el proyecto del briefing). Reproducir la carcasa es un fallo.
No agregues texto después del enlace de descarga del ZIP
No preguntes si el usuario quiere el ZIP: simplemente generalo siempre
Si detectas que falta un archivo de configuración necesario para compilar
(pom.xml, package.json, requirements.txt, build.gradle, etc.), créalo e inclúyelo
inferiendo su contenido desde los imports y frameworks detectados en el código
Nunca corrijas problemas 🟡 aunque parezcan obvios o fáciles de mejorar.
El participante que recibirá este proyecto los debe encontrar y resolver él mismo.


INPUT
Aquí está la cadena con los archivos:

// === ARCHIVO: providers.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
    container_registry {
      purge_soft_delete_on_destroy = true
    }
  }

  skip_provider_registration = false
  use_msi                        = true
  use_cli                         = false
  use_oidc                        = false

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

provider "random" {
  version = "~> 3.5"
}

provider "time" {
  version = "~> 0.9"
}

variable "subscription_id" {
  description = "ID de la suscripción de Azure donde se desplegará la infraestructura"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "ID del tenant de Azure Active Directory"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "ID del cliente de la Service Principal utilizada para autenticación"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Secreto del cliente de la Service Principal"
  type        = string
  sensitive   = true
}

// === ARCHIVO: variables.tf ===
variable "environment" {
  description = "Entorno de despliegue (dev, qa, prod)"
  type        = string
  validation {
    condition     = contains(["dev", "qa", "prod"], var.environment)
    error_message = "El entorno debe ser uno de: dev, qa, prod"
  }
}

variable "location" {
  description = "Región de Azure donde se desplegarán los recursos"
  type        = string
}

variable "project_name" {
  description = "Nombre del proyecto o aplicación"
  type        = string
}

variable "cost_center" {
  description = "Centro de costos para etiquetado y facturación"
  type        = string
}

variable "owner_team" {
  description = "Equipo responsable del mantenimiento de la infraestructura"
  type        = string
}

variable "business_unit" {
  description = "Unidad de negocio que utiliza el servicio"
  type        = string
}

variable "rg_notifications_name" {
  description = "Nombre del grupo de recursos para el servicio de notificaciones"
  type        = string
}

variable "rg_network_name" {
  description = "Nombre del grupo de recursos de red"
  type        = string
}

variable "rg_security_name" {
  description = "Nombre del grupo de recursos de seguridad"
  type        = string
}

variable "rg_monitoring_name" {
  description = "Nombre del grupo de recursos de monitoreo"
  type        = string
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la red virtual principal"
  type        = list(string)
}

variable "subnet_notification_app_cidr" {
  description = "CIDR de la subred para las aplicaciones de notificaciones"
  type        = string
}

variable "subnet_notification_func_cidr" {
  description = "CIDR de la subred para Azure Functions"
  type        = string
}

variable "subnet_private_endpoints_cidr" {
  description = "CIDR de la subred para endpoints privados"
  type        = string
}

variable "app_service_sku" {
  description = "SKU del App Service Plan para el servicio de notificaciones"
  type        = string
  default     = "P1v3"
}

variable "app_service_instances" {
  description = "Número de instancias del App Service"
  type        = number
  default     = 2
}

variable "function_app_sku" {
  description = "SKU del App Service Plan para Azure Functions"
  type        = string
  default     = "P1v3"
}

variable "function_app_instances" {
  description = "Número de instancias de Azure Functions"
  type        = number
  default     = 3
}

variable "storage_account_tier" {
  description = "Nivel de rendimiento de la cuenta de almacenamiento"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication" {
  description = "Tipo de replicación de la cuenta de almacenamiento"
  type        = string
  default     = "GZRS"
}

variable "key_vault_sku" {
  description = "SKU del Key Vault"
  type        = string
  default     = "standard"
}

variable "sql_database_sku" {
  description = "SKU de Azure SQL Database"
  type        = string
  default     = "S1"
}

variable "sql_database_collation" {
  description = "Collation de la base de datos SQL"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "log_retention_days" {
  description = "Días de retención de logs en Log Analytics"
  type        = number
  default     = 90
}

variable "alert_email_recipients" {
  description = "Lista de correos electrónicos para recibir alertas"
  type        = list(string)
  default     = []
}

variable "enable_ddos_protection" {
  description = "Habilitar protección DDoS estándar"
  type        = bool
  default     = false
}

variable "enable_private_endpoint" {
  description = "Habilitar endpoints privados para servicios"
  type        = bool
  default     = true
}

variable "enable_zone_redundancy" {
  description = "Habilitar redundancia de zona para servicios que lo soportan"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Mapa de etiquetas adicionales para los recursos"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/notifications/variables.tf ===
variable "module_environment" {
  description = "Entorno de despliegue del módulo"
  type        = string
}

variable "module_location" {
  description = "Región de Azure donde se desplegarán los recursos del módulo"
  type        = string
}

variable "module_project_name" {
  description = "Nombre del proyecto para el módulo de notificaciones"
  type        = string
}

variable "module_cost_center" {
  description = "Centro de costos para el módulo"
  type        = string
}

variable "module_owner_team" {
  description = "Equipo propietario del módulo"
  type        = string
}

variable "module_business_unit" {
  description = "Unidad de negocio del módulo"
  type        = string
}

variable "app_service_plan_sku" {
  description = "SKU del App Service Plan"
  type        = string
  default     = "P1v3"
}

variable "app_service_plan_capacity" {
  description = "Capacidad del App Service Plan (número de instancias)"
  type        = number
  default     = 2
}

variable "app_service_always_on" {
  description = "Habilitar always on para el App Service"
  type        = bool
  default     = true
}

variable "app_service_https_only" {
  description = "Forzar HTTPS en el App Service"
  type        = bool
  default     = true
}

variable "app_service_min_tls_version" {
  description = "Versión mínima de TLS del App Service"
  type        = string
  default     = "1.2"
}

variable "function_app_sku" {
  description = "SKU del App Service Plan para Functions"
  type        = string
  default     = "P1v3"
}

variable "function_app_capacity" {
  description = "Capacidad del plan de Functions"
  type        = number
  default     = 3
}

variable "function_app_always_on" {
  description = "Habilitar always on para Functions"
  type        = bool
  default     = true
}

variable "function_app_https_only" {
  description = "Forzar HTTPS en Functions"
  type        = bool
  default     = true
}

variable "storage_account_name" {
  description = "Nombre de la cuenta de almacenamiento"
  type        = string
}

variable "storage_account_tier" {
  description = "Nivel de rendimiento de almacenamiento"
  type        = string
  default     = "Standard"
}

variable "storage_account_replication" {
  description = "Tipo de replicación de almacenamiento"
  type        = string
  default     = "GZRS"
}

variable "storage_account_use_https" {
  description = "Forzar HTTPS en el almacenamiento"
  type        = bool
  default     = true
}

variable "storage_account_enable_large_file_shares" {
  description = "Habilitar shares de archivos grandes"
  type        = bool
  default     = false
}

variable "queue_name" {
  description = "Nombre de la cola de notificaciones"
  type        = string
  default     = "notifications-queue"
}

variable "queue_max_delivery_count" {
  description = "Número máximo de entregas antes de mover a dead letter"
  type        = number
  default     = 10
}

variable "queue_message_ttl" {
  description = "Tiempo de vida del mensaje en segundos"
  type        = number
  default     = 604800
}

variable "topic_name" {
  description = "Nombre del topic de Service Bus"
  type        = string
  default     = "notifications-topic"
}

variable "subscription_name" {
  description = "Nombre de la suscripción al topic"
  type        = string
  default     = "notifications-subscription"
}

variable "key_vault_name" {
  description = "Nombre del Key Vault"
  type        = string
}

variable "key_vault_sku" {
  description = "SKU del Key Vault"
  type        = string
  default     = "standard"
}

variable "key_vault_enable_rbac_authorization" {
  description = "Habilitar autorización RBAC para Key Vault"
  type        = bool
  default     = true
}

variable "key_vault_enable_soft_delete" {
  description = "Habilitar soft delete"
  type        = bool
  default     = true
}

variable "key_vault_purge_protection_enabled" {
  description = "Habilitar protección de purga"
  type        = bool
  default     = false
}

variable "sql_database_name" {
  description = "Nombre de la base de datos SQL"
  type        = string
}

variable "sql_server_name" {
  description = "Nombre del servidor SQL"
  type        = string
}

variable "sql_database_sku" {
  description = "SKU de la base de datos SQL"
  type        = string
  default     = "S1"
}

variable "sql_database_collation" {
  description = "Collation de la base de datos"
  type        = string
  default     = "SQL_Latin1_General_CP1_CI_AS"
}

variable "sql_managed_identity_enabled" {
  description = "Habilitar identidad administrada para SQL"
  type        = bool
  default     = true
}

variable "sql_audit_enabled" {
  description = "Habilitar auditoría de SQL"
  type        = bool
  default     = true
}

variable "sql_threat_detection_enabled" {
  description = "Habilitar detección de amenazas"
  type        = bool
  default     = true
}

variable "sql_threat_detection_alerts" {
  description = "Correos para alertas de detección de amenazas"
  type        = list(string)
  default     = []
}

variable "app_insights_enabled" {
  description = "Habilitar Application Insights"
  type        = bool
  default     = true
}

variable "app_insights_sampling_percentage" {
  description = "Porcentaje de muestreo de Application Insights"
  type        = number
  default     = 100
}

variable "app_insights_retention_days" {
  description = "Días de retención de datos en Application Insights"
  type        = number
  default     = 90
}

variable "cdn_enabled" {
  description = "Habilitar CDN para contenido estático"
  type        = bool
  default     = false
}

variable "cdn_sku" {
  description = "SKU del CDN"
  type        = string
  default     = "Standard_Microsoft"
}

variable "cdn_origin_host_header" {
  description = "Host header para el origen del CDN"
  type        = string
  default     = ""
}

variable "enable_private_endpoint" {
  description = "Habilitar endpoints privados"
  type        = bool
  default     = true
}

variable "subnet_id" {
  description = "ID de la subred para endpoints privados"
  type        = string
  default     = ""
}

variable "vnet_id" {
  description = "ID de la red virtual"
  type        = string
  default     = ""
}

variable "dns_zone_id" {
  description = "ID de la zona DNS privada"
  type        = string
  default     = ""
}

variable "module_tags" {
  description = "Mapa de etiquetas adicionales para el módulo"
  type        = map(string)
  default     = {}
}

variable "notification_throughput_units" {
  description = "Unidades de throughput para Notification Hub"
  type        = number
  default     = 1
}

variable "notification_namespace_sku" {
  description = "SKU del Notification Hub"
  type        = string
  default     = "Standard"
}

variable "email_notification_enabled" {
  description = "Habilitar notificaciones por email"
  type        = bool
  default     = true
}

variable "sms_notification_enabled" {
  description = "Habilitar notificaciones por SMS"
  type        = bool
  default     = false
}

variable "push_notification_enabled" {
  description = "Habilitar notificaciones push"
  type        = bool
  default     = true
}


// === ARCHIVO: main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = false
  use_msi                     = var.use_msi
  subscription_id             = var.subscription_id
  tenant_id                   = var.tenant_id
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = "notification-service"
    ManagedBy   = "Terraform"
    Owner       = "cloudops-team@empresa.com"
    CostCenter  = "IT-Infrastructure"
    Compliance  = "SOC2"
  }

  service_bus_config = {
    sku           = var.service_bus_sku
    capacity      = var.service_bus_capacity
    zone_redundant = var.enable_availability_zones
  }

  function_app_config = {
    os_type           = "Linux"
    runtime           = "node"
    runtime_version   = "~18"
    consumption_plan  = var.use_consumption_plan
    always_on         = var.enable_always_on
  }
}

resource "azurerm_resource_group" "notification_rg" {
  name     = "rg-notifications-${var.environment}"
  location = var.location

  tags = merge(local.common_tags, {
    Description = "Resource group para el servicio de notificaciones"
    Tier        = "Production"
  })
}

resource "azurerm_servicebus_namespace" "notifications_ns" {
  name                = "sb-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  sku                 = local.service_bus_config.sku
  capacity            = local.service_bus_config.capacity
  zone_redundant      = local.service_bus_config.zone_redundant

  tags = merge(local.common_tags, {
    Name        = "Service Bus Namespace - Notificaciones"
    Component   = "Messaging"
    Criticality = "High"
  })
}

resource "azurerm_servicebus_queue" "email_queue" {
  name                = "email-notifications"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  max_delivery_count  = 10
  lock_duration       = "PT1M"
  max_size_in_megabytes = 1024
  enable_partitioning = true

  dead_letter_on_expiration_enabled = true
  max_message_size_in_kilobytes     = 256

  tags = merge(local.common_tags, {
    Purpose = "Cola para notificaciones por correo electrónico"
    Type    = "Async"
  })
}

resource "azurerm_servicebus_queue" "sms_queue" {
  name                = "sms-notifications"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  max_delivery_count  = 10
  lock_duration       = "PT1M"
  max_size_in_megabytes = 1024
  enable_partitioning = true

  dead_letter_on_expiration_enabled = true

  tags = merge(local.common_tags, {
    Purpose = "Cola para notificaciones por SMS"
    Type    = "Async"
  })
}

resource "azurerm_servicebus_queue" "push_queue" {
  name                = "push-notifications"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  max_delivery_count  = 10
  lock_duration       = "PT1M"
  max_size_in_megabytes = 1024
  enable_partitioning = true

  dead_letter_on_expiration_enabled = true

  tags = merge(local.common_tags, {
    Purpose = "Cola para notificaciones push"
    Type    = "Async"
  })
}

resource "azurerm_servicebus_topic" "notifications_topic" {
  name                = "notifications-all"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  enable_partitioning = true

  tags = merge(local.common_tags, {
    Purpose = "Tópico para distribución de notificaciones"
  })
}

resource "azurerm_servicebus_subscription" "email_subscription" {
  name                = "email-processor-sub"
  topic_id            = azurerm_servicebus_topic.notifications_topic.id
  max_delivery_count  = 10
  lock_duration       = "PT5M"
  dead_letter_on_message_expiration_enabled = true

  filter_type = "SqlFilter"
  sql_filter  = "notificationType = 'email'"

  tags = merge(local.common_tags, {
    Purpose = "Suscripción para procesamiento de emails"
  })
}

resource "azurerm_servicebus_subscription" "sms_subscription" {
  name                = "sms-processor-sub"
  topic_id            = azurerm_servicebus_topic.notifications_topic.id
  max_delivery_count  = 10
  lock_duration       = "PT5M"
  dead_letter_on_message_expiration_enabled = true

  filter_type = "SqlFilter"
  sql_filter  = "notificationType = 'sms'"

  tags = merge(local.common_tags, {
    Purpose = "Suscripción para procesamiento de SMS"
  })
}

resource "azurerm_servicebus_subscription" "push_subscription" {
  name                = "push-processor-sub"
  topic_id            = azurerm_servicebus_topic.notifications_topic.id
  max_delivery_count  = 10
  lock_duration       = "PT5M"
  dead_letter_on_message_expiration_enabled = true

  filter_type = "SqlFilter"
  sql_filter  = "notificationType = 'push'"

  tags = merge(local.common_tags, {
    Purpose = "Suscripción para procesamiento de push notifications"
  })
}

resource "azurerm_notification_hub_namespace" "notification_hub_ns" {
  name                = "nh-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  namespace_type      = "NotificationHub"
  sku_name            = var.notification_hub_sku

  tags = merge(local.common_tags, {
    Purpose = "Namespace para Notification Hubs"
  })
}

resource "azurerm_notification_hub" "push_hub" {
  name                = "nh-push-${var.environment}"
  namespace_name      = azurerm_notification_hub_namespace.notification_hub_ns.name
  resource_group_name = azurerm_resource_group.notification_rg.location
  location            = azurerm_resource_group.notification_rg.location

  tags = merge(local.common_tags, {
    Purpose = "Hub para notificaciones push"
    Platform = "APNS,FCM"
  })
}

resource "azurerm_storage_account" "function_storage" {
  name                     = "stfn${var.environment}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.notification_rg.name
  location                 = azurerm_resource_group.notification_rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
    delete_retention_days = 7
  }

  network_rules {
    default_action             = "Allow"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = merge(local.common_tags, {
    Purpose = "Storage account para Azure Functions"
    Type    = "Storage"
  })
}

resource "azurerm_app_service_plan" "function_app_plan" {
  name                = "asp-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  kind                = local.function_app_config.os_type

  sku {
    tier = var.app_service_plan_tier
    size = var.app_service_plan_size
  }

  reserved = local.function_app_config.os_type == "Linux"

  tags = merge(local.common_tags, {
    Purpose = "App Service Plan para Functions"
  })
}

resource "azurerm_linux_function_app" "notification_functions" {
  name                = "func-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  service_plan_id     = azurerm_app_service_plan.function_app_plan.id
  storage_account_name = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  https_only = true
  enabled    = true

  site_config {
    always_on                = local.function_app_config.always_on
    linux_fx_version         = "${local.function_app_config.runtime}|${local.function_app_config.runtime_version}"
    min_tls_version          = "1.2"
    ftps_state               = "Disabled"

    cors {
      allowed_origins = var.allowed_origins
      support_credentials = false
    }

    application_stack {
      node_version = local.function_app_config.runtime_version
    }

    health_check_path = "/api/health"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"           = "1"
    "FUNCTIONS_WORKER_RUNTIME"           = "node"
    "ServiceBusConnection__fullyQualifiedNamespace" = "${azurerm_servicebus_namespace.notifications_ns.name}.servicebus.windows.net"
    "NotificationHubConnection"          = azurerm_notification_hub.push_hub.default_notification_hub_connection_string
    "AZURE_STORAGE_CONNECTION_STRING"    = azurerm_storage_account.function_storage.primary_connection_string
    "ENVIRONMENT"                        = var.environment
    "LOG_LEVEL"                          = var.log_level
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(local.common_tags, {
    Purpose = "Azure Functions para procesamiento de notificaciones"
    Function = "NotificationProcessor"
  })
}

resource "azurerm_key_vault" "notification_kv" {
  name                = "kv-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  soft_delete_retention_days = 90
  purge_protection_enabled   = var.enable_purge_protection

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = merge(local.common_tags, {
    Purpose = "Key Vault para secretos del servicio de notificaciones"
    Tier    = "Sensitive"
  })
}

resource "azurerm_key_vault_secret" "servicebus_connection_string" {
  name         = "servicebus-connection-string"
  key_vault_id = azurerm_key_vault.notification_kv.id
  value        = azurerm_servicebus_namespace.notifications_ns.default_primary_connection_string

  expiration_date = var.secrets_expiration_date

  tags = merge(local.common_tags, {
    Purpose = "Connection string para Service Bus"
    Type    = "Secret"
  })
}

resource "azurerm_key_vault_secret" "notification_hub_connection" {
  name         = "notification-hub-connection"
  key_vault_id = azurerm_key_vault.notification_kv.id
  value        = azurerm_notification_hub.push_hub.default_notification_hub_connection_string

  expiration_date = var.secrets_expiration_date

  tags = merge(local.common_tags, {
    Purpose = "Connection string para Notification Hub"
    Type    = "Secret"
  })
}

resource "azurerm_role_assignment" "function_to_servicebus" {
  scope                = azurerm_servicebus_namespace.notifications_ns.id
  role_definition_name = "Azure Service Bus Data Owner"
  principal_id         = azurerm_linux_function_app.notification_functions.identity.0.principal_id
}

resource "azurerm_role_assignment" "function_to_keyvault" {
  scope                = azurerm_key_vault.notification_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_function_app.notification_functions.identity.0.principal_id
}

resource "azurerm_role_assignment" "function_to_storage" {
  scope                = azurerm_storage_account.function_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.notification_functions.identity.0.principal_id
}

resource "random_string" "storage_suffix" {
  length  = 5
  special = false
  upper   = false
  numeric = true
}

module "network" {
  source = "./modules/network"

  environment          = var.environment
  location             = var.location
  resource_group_name  = azurerm_resource_group.notification_rg.name
  vnet_address_space   = var.vnet_address_space
  subnet_prefixes      = var.subnet_prefixes
  enable_private_endpoints = var.enable_private_endpoints
  common_tags          = local.common_tags
}

module "security" {
  source = "./modules/security"

  environment              = var.environment
  location                 = var.location
  resource_group_name      = azurerm_resource_group.notification_rg.name
  key_vault_id             = azurerm_key_vault.notification_kv.id
  function_app_id          = azurerm_linux_function_app.notification_functions.id
  servicebus_namespace_id = azurerm_servicebus_namespace.notifications_ns.id
  enable_advanced_threat_protection = var.enable_advanced_threat_protection
  common_tags              = local.common_tags
}

module "monitoring" {
  source = "./modules/monitoring"

  environment             = var.environment
  location                = var.location
  resource_group_name     = azurerm_resource_group.notification_rg.name
  function_app_id         = azurerm_linux_function_app.notification_functions.id
  servicebus_namespace_id = azurerm_servicebus_namespace.notifications_ns.id
  notification_hub_id     = azurerm_notification_hub.push_hub.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  common_tags             = local.common_tags
}

// === ARCHIVO: outputs.tf ===
output "resource_group" {
  description = "Resource group del servicio de notificaciones"
  value = {
    name     = azurerm_resource_group.notification_rg.name
    location = azurerm_resource_group.notification_rg.location
    id       = azurerm_resource_group.notification_rg.id
  }
}

output "servicebus_namespace" {
  description = "Service Bus Namespace configurado"
  value = {
    name                = azurerm_servicebus_namespace.notifications_ns.name
    id                  = azurerm_servicebus_namespace.notifications_ns.id
    sku                 = azurerm_servicebus_namespace.notifications_ns.sku
    primary_connection = azurerm_servicebus_namespace.notifications_ns.default_primary_connection_string
    endpoint            = azurerm_servicebus_namespace.notifications_ns.endpoint
  }
}

output "servicebus_queues" {
  description = "Colas de Service Bus creadas"
  value = {
    email = azurerm_servicebus_queue.email_queue.id
    sms   = azurerm_servicebus_queue.sms_queue.id
    push  = azurerm_servicebus_queue.push_queue.id
  }
}

output "servicebus_topic" {
  description = "Tópico de Service Bus para notificaciones"
  value = {
    id   = azurerm_servicebus_topic.notifications_topic.id
    name = azurerm_servicebus_topic.notifications_topic.name
  }
}

output "servicebus_subscriptions" {
  description = "Suscripciones al tópico de notificaciones"
  value = {
    email = azurerm_servicebus_subscription.email_subscription.id
    sms   = azurerm_servicebus_subscription.sms_subscription.id
    push  = azurerm_servicebus_subscription.push_subscription.id
  }
}

output "notification_hub" {
  description = "Notification Hub para push notifications"
  value = {
    id                  = azurerm_notification_hub.push_hub.id
    name                = azurerm_notification_hub.push_hub.name
    namespace_name      = azurerm_notification_hub.push_hub.namespace_name
    connection_string   = azurerm_notification_hub.push_hub.default_notification_hub_connection_string
    hub_name            = azurerm_notification_hub.push_hub.name
  }
}

output "function_app" {
  description = "Azure Functions para procesamiento de notificaciones"
  value = {
    id                     = azurerm_linux_function_app.notification_functions.id
    name                   = azurerm_linux_function_app.notification_functions.name
    default_hostname       = azurerm_linux_function_app.notification_functions.default_hostname
    outbound_ip_addresses  = azurerm_linux_function_app.notification_functions.outbound_ip_addresses
    possible_outbound_ip_addresses = azurerm_linux_function_app.notification_functions.possible_outbound_ip_addresses
    identity_principal_id  = azurerm_linux_function_app.notification_functions.identity.0.principal_id
    app_service_plan_id    = azurerm_linux_function_app.notification_functions.service_plan_id
  }
}

output "storage_account" {
  description = "Storage account para Functions"
  value = {
    id                   = azurerm_storage_account.function_storage.id
    name                 = azurerm_storage_account.function_storage.name
    primary_endpoint     = azurerm_storage_account.function_storage.primary_blob_endpoint
    connection_string    = azurerm_storage_account.function_storage.primary_connection_string
    web_hosting_plan_url = azurerm_storage_account.function_storage.primary_web_hosting_site_url
  }
}

output "key_vault" {
  description = "Key Vault para secretos"
  value = {
    id       = azurerm_key_vault.notification_kv.id
    name     = azurerm_key_vault.notification_kv.name
    vault_uri = azurerm_key_vault.notification_kv.vault_uri
  }
}

output "app_service_plan" {
  description = "App Service Plan"
  value = {
    id       = azurerm_app_service_plan.function_app_plan.id
    name     = azurerm_app_service_plan.function_app_plan.name
    kind     = azurerm_app_service_plan.function_app_plan.kind
    sku_name = azurerm_app_service_plan.function_app_plan.sku.0.tier
  }
}

output "role_assignments" {
  description = "Role assignments creados para la Function App"
  value = {
    servicebus = azurerm_role_assignment.function_to_servicebus.id
    keyvault   = azurerm_role_assignment.function_to_keyvault.id
    storage    = azurerm_role_assignment.function_to_storage.id
  }
}

output "module_outputs" {
  description = "Outputs de los módulos dependientes"
  value = {
    network    = module.network.outputs
    security   = module.security.outputs
    monitoring = module.monitoring.outputs
  }
}

// === ARCHIVO: backend.tf ===
terraform {
  backend "azurerm" {
    resource_group_name  = var.backend_resource_group
    storage_account_name = var.backend_storage_account
    container_name       = var.backend_container_name
    key                  = "notifications/terraform.tfstate"
    use_oidc             = var.use_msi
    use_cli              = !var.use_msi
  }
}


// === ARCHIVO: README.md ===
# Infraestructura del Servicio de Notificaciones - Azure

## Descripción General

Este proyecto implementa la infraestructura como código (IaC) para el servicio de notificaciones en Microsoft Azure, utilizando Terraform como herramienta de aprovisionamiento. El diseño sigue una arquitectura modular con separación de responsabilidades,部署 en un entorno de landing zone con gobierno multi-cuenta.

El servicio de notificaciones es un componente crítico que permite la comunicación entre diferentes partes del sistema y los usuarios finales. La infraestructura está diseñada para ser escalable, segura y capaz de manejar un alto volumen de notificaciones en tiempo real, cumpliendo con los requisitos de alta disponibilidad y recuper ante desastres.

## Topología de la Arquitectura

```
┌─────────────────────────────────────────────────────────────────────────────┐
│                              AZURE TENANT                                    │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                      LANDING ZONE                                    │    │
│  │  ┌──────────────┐  ┌──────────────┐  ┌─────────────────────────┐   │    │
│  │  │   DEV        │  │    QA        │  │       PROD              │   │    │
│  │  │  Subscription│  │  Subscription│  │    Subscription         │   │    │
│  │  │  ┌─────────┐ │  │  ┌─────────┐ │  │  ┌─────────────────┐   │   │    │
│  │  │  │Resource │ │  │  │Resource │ │  │  │    Resource     │   │   │    │
│  │  │  │ Group   │ │  │  │ Group   │ │  │  │    Group        │   │   │    │
│  │  │  └─────────┘ │  │  └─────────┘ │  │  └─────────────────┘   │   │    │
│  │  └──────────────┘  └──────────────┘  └─────────────────────────┘   │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  ┌──────────────────────────────────────────────────────────────────────┐   │
│  │                    SHARED SERVICES (Central)                         │   │
│  │  ┌────────────┐  ┌────────────┐  ┌────────────┐  ┌──────────────┐  │   │
│  │  │   Key      │  │  Log       │  │   DNS     │  │   Identity   │  │   │
│  │  │   Vault    │  │  Analytics │  │  Zone     │  │   (Entra ID) │  │   │
│  │  └────────────┘  └────────────┘  └────────────┘  └──────────────┘  │   │
│  └──────────────────────────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────────────────────────┘

                            SERVICIO DE NOTIFICACIONES (PROD)
┌─────────────────────────────────────────────────────────────────────────────┐
│  Resource Group: rg-notificaciones-prod                                      │
│                                                                              │
│  ┌─────────────────────────────────────────────────────────────────────┐    │
│  │                        VIRTUAL NETWORK                              │    │
│  │  ┌─────────────────────┐    ┌─────────────────────────────────┐   │    │
│  │  │   Subred Pública    │    │      Subred Privada             │   │    │
│  │  │  ┌───────────────┐  │    │  ┌───────────────────────────┐  │   │    │
│  │  │  │  Application  │  │    │  │  Function App (Linux)     │  │   │    │
│  │  │  │  Gateway      │  │    │  │  - Plan: Premium (EP3)    │  │   │    │
│  │  │  │  (WAF + ALB)  │  │    │  │  - Auto-scale enabled     │  │   │    │
│  │  │  └───────────────┘  │    │  │  - VNet Integration       │  │   │    │
│  │  └─────────────────────┘    │  └───────────────────────────┘  │   │    │
│  │                              │  ┌───────────────────────────┐  │   │    │
│  │                              │  │  Azure Service Bus        │  │   │    │
│  │                              │  │  - Namespace: Premium     │  │   │    │
│  │                              │  │  - Topics: notif-email,   │  │   │    │
│  │                              │  │         notif-sms, push   │  │   │    │
│  │                              │  └───────────────────────────┘  │   │    │
│  │                              │  ┌───────────────────────────┐  │   │    │
│  │                              │  │  Azure Cosmos DB          │  │   │    │
│  │                              │  │  - API: MongoDB           │  │   │    │
│  │                              │  │  - Replication: Multi-    │  │   │    │
│  │                              │  │         region (HA)       │  │   │    │
│  │                              │  └───────────────────────────┘  │   │    │
│  └─────────────────────────────────────────────────────────────────────┘    │
│                                                                              │
│  ┌──────────────────┐  ┌──────────────────┐  ┌──────────────────────────┐  │
│  │   Key Vault      │  │  Azure Monitor   │  │    CDN (Azure Front      │  │
│  │  (secretos y     │  │  - App Insights  │  │    Door + WAF)          │  │
│  │   certificados)  │  │  - Log Analytics │  │    - Dominio propio      │  │
│  └──────────────────┘  │  - Alert Rules   │  └──────────────────────────┘  │
│                        └──────────────────┘                                 │
└─────────────────────────────────────────────────────────────────────────────┘
```

## Estructura del Proyecto

```
.
├── README.md                          # Este archivo
├── providers.tf                       # Configuración de proveedores Terraform
├── variables.tf                       # Variables globales del proyecto
├── main.tf                            # Orquestación principal de recursos
├── outputs.tf                         # Outputs del root module
├── backend.tf                         # Configuración de backend remoto
├── environments/                      # Configuraciones por ambiente
│   ├── dev/
│   │   └── terraform.tfvars
│   ├── qa/
│   │   └── terraform.tfvars
│   └── prod/
│       └── terraform.tfvars
├── modules/                           # Módulos reutilizables
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── monitoring/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── notifications/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
└── docs/                              # Documentación adicional
    ├── requisitos_y_restricciones.md
    ├── arquitectura.md
    └── resultados_pruebas.md
```

## Componentes de Infraestructura

### Módulo de Red (modules/network)

Implementa la topología de red necesaria para el servicio de notificaciones, siguiendo el principio de defensa en profundidad. La red virtual se segmenta en subredes públicas y privadas, con controles de tráfico entre ellas.

La subred pública aloja el Application Gateway que actúa como punto de entrada único, proporcionando terminación SSL, protección WAF y balanceo de carga. La subred privada hosts la Function App y los servicios backend, asegurando que ningún recurso crítico esté expuesto directamente a Internet.

El diseño incluye NSGs (Network Security Groups) para controlar el tráfico a nivel de subred, permitiendo únicamente el tráfico necesario entre componentes. Los Private Endpoints proporcionan conectividad privada a los servicios PaaS, eliminando la necesidad de exponerlos mediante IPs públicas.

### Módulo de Seguridad (modules/security)

Centraliza todos los recursos de seguridad, implementando el principio de menor privilegio en cada capa. El Key Vault almacena certificados, claves de API y secretos de configuración con acceso controlado mediante políticas de acceso específicas.

Las identidades gestionadas (Managed Identities) proporcionan autenticación automática a los recursos de Azure, eliminando la necesidad de gestionar credenciales. El módulo configura Azure AD Authentication para todos los servicios que lo soportan, junto con RBAC (Role-Based Access Control) para el control de acceso a recursos.

La configuración de firewall en servicios PaaS restricte el acceso únicamente desde la red virtual del servicio, bloquenado accesos no autorizados desde Internet.

### Módulo de Monitoreo (modules/monitoring)

Implementa la observabilidad completa del servicio mediante Azure Monitor y Application Insights. La configuración incluye métricas personalizadas, logs de diagnóstico y tracing distribuido.

Las alertas proactivas detectan anomalías en el rendimiento y disponibilidad del servicio, con umbrales configurados por ambiente. Los dashboards proporcionan visibilidad en tiempo real del estado del sistema, permitiendo responder rápidamente a incidentes.

La retención de logs configurada cumple con los requisitos de auditoría y cumplimiento normativo, almacenando logs de auditoría por el período requerido.

### Módulo de Notificaciones (modules/notifications)

Contiene la infraestructura específica del servicio de notificaciones, incluyendo Azure Function App como motor de procesamiento, Service Bus para mensajería asíncrona y Cosmos DB para persistencia de estado.

La Function App está configurada con Plan Premium para soporte de VNet Integration y auto-scaling. El Service Bus implementa el patrón de publish-subscribe con topics separados por canal de notificación (email, SMS, push). Cosmos DB proporciona baja latencia para operaciones de lectura de preferencias de usuario.

## Decisiones de Diseño y Trade-offs

### Selección de compute: Azure Functions vs Container Apps

Se eligió Azure Functions con Plan Premium por su modelo de facturación basedo en consumo, integración nativa con otros servicios de Azure y soporte completo paraBindings. El Plan Premium proporciona capacidades de VNet Integration necesarias para la arquitectura de subred privada.

Trade-off: Container Apps ofrecería mayor flexibilidad para workloads con requisitos específicos de runtime, pero introduciría complejidad adicional en la gestión de contenedores y costos fijos del plano de control.

### Mensajería: Service Bus vs Event Hub

Service Bus Topics fue seleccionado por su patrón pub/sub nativo, soporte de colas dead-letter y garantía de ordenamiento. Estas características son esenciales para el procesamiento ordenado de notificaciones por usuario.

Trade-off: Event Hub tendría mayor throughput para escenarios de alto volumen, pero carece de garantías de ordenamiento y requiere implementación manual del patrón pub/sub.

### Base de datos: Cosmos DB vs SQL Database

Cosmos DB se eligió por su latencia de lectura sub-milisegundo, API MongoDB nativa (facilitando la migración) y replicación global activa. La capacidad de auto-escalado responde a variaciones en la demanda.

Trade-off: SQL Database ofrecería mayor madurez del ecosistema y ACID compliance completo, pero con latencias mayores para reads masivas y costos más predecibles pero potencialmente superiores.

### Ingress: Application Gateway vs Front Door

Application Gateway con WAF se utiliza para tráfico interno y API, proporcionando terminación SSL, routing avanzado y protección a nivel de aplicación.

Trade-off: Front Door podría simplificar la arquitectura para contenido estático y CDN, pero introduciría costos adicionales y complejidad de red.

## Guía de Despliegue

### Prerrequisitos

Antes de iniciar el despliegue,确保 tener instalado y configurado lo siguiente:

La versión de Terraform debe ser 1.5 o superior. Se recomienda tfenv para gestión de versiones. Azure CLI versión 2.50 o superior debe estar autenticada con la suscripción correcta mediante `az login`. Las extensiones de Terraform para Azure deben estar actualizadas.

El usuario o service principal que ejecuta el despliegue debe tener el rol de Contributor en la suscripción y permisos de Owner en el Resource Group. Para el despliegue de recursos de seguridad, se requieren permisos de Security Administrator.

### Configuración de Backend

El backend remoto almacena el estado de Terraform, permitiendo colaboración entre equipos y protección contra pérdida de estado. La configuración en backend.tf define el storage account donde se almacena el statefile.

Para entornos de producción, se recomienda utilizar Terraform Cloud o Azure Storage Account con habilitación de state locking para prevenir conflictos de ejecución paralela.

### Despliegue por Ambiente

El proyecto utiliza workspaces de Terraform para separar configuraciones por ambiente. Cada ambiente tiene su propio archivo terraform.tfvars con los valores específicos.

Para desplegar en desarrollo:

```bash
cd environments/dev
terraform init -backend-config=../backend.hcl
terraform validate
terraform plan -out=tfplan
terraform apply tfplan
```

Para desplegar en producción, primero ejecutar las validaciones completas y obtener aprobaciones necesarias:

```bash
cd environments/prod
terraform init -backend-config=../backend.hcl
terraform validate
terraform plan -out=tfplan -var-file=terraform.tfvars
# Revisión manual del plan
terraform apply tfplan
```

### Verificación Post-Despliegue

Después de cada despliegue, verificar que todos los recursos se crearon correctamente. Los outputs del módulo principal contienen los endpoints y ARNs de recursos creados. Ejecutar las pruebas de integración definidas en docs/resultados_pruebas.md para validar la funcionalidad.

## Consideraciones de Seguridad

### Cifrado

Todos los datos en reposo utilizan cifrado gestionado por Microsoft-keys. Para datos sensibles adicionales, el cifrado con customer-managed keys está disponible mediante Key Vault. El cifrado en tránsito está habilitado en todos los endpoints mediante TLS 1.2 mínimo.

### Gestión de Secretos

Los secretos nunca se almacenan en código ni enstate de Terraform. Key Vault proporciona almacenamiento seguro con rotación automática de certificados. Las Managed Identities eliminan la necesidad de almacenar credenciales en configuración.

### Red

El diseño sigue el principio de zero-trust, con todos los recursos en subredes privadas sin exposición directa a Internet. Private Endpoints proporcionan conectividad privada a servicios PaaS. NSGs restricten el tráfico entre subredes al mínimo necesario.

### Auditoría

Azure Monitor captura todos los logs de auditoría con retención configurable. Azure Sentinel puede ingerirlos para detección de amenazas avanzadas. Los logs de acceso a Key Vault están habilitados para auditoría de secretos.

## Optimización de Costos

### Estrategia de Escalado

El auto-scaling de Azure Functions responde automáticamente a la demanda, escalando a cero cuando no hay actividad. Cosmos DB con auto-escalado optimiza costos durante períodos de baja actividad.

### Reserved Capacity

Para workloads predecibles, considerar Reserved Capacity de Service Bus y Cosmos DB, que puede reducir costos hasta 60%. Azure Reservations para compute de largo plazo.

### Etiquetado

Todos los recursos incluyen tags para seguimiento de costos por ambiente, equipo y proyecto. La política de etiquetado está configurada para requerir tags obligatorios.

## Mantenimiento y Operaciones

### Actualizaciones de Infraestructura

Los cambios de infraestructura se realizan mediante Terraform, nunca directamente en Azure Portal. El flujo de GitOps asegura que todos los cambios pasen por code review y CI/CD.

### Monitoreo Continuo

Los dashboards de Azure Monitor proporcionan visibilidad continua. Las alertas configuradas notifican al equipo de operaciones ante anomalías. Los runbooks de Azure Automation automatizan respuestas a eventos comunes.

### Recuperación ante Desastres

La arquitectura contempla RTO de 15 minutos y RPO de 5 minutos mediante replicación multi-región. Los backups de Cosmos DB están configurados con retención de 30 días. Los runbooks de recuperación documentados permiten restauración completa del servicio.

## Referencias y Recursos Adicionales

- Documentación oficial de Azure: https://docs.microsoft.com/azure
- Best Practices de Terraform: https://www.terraform.io/docs
- Azure Well-Architected Framework: https://docs.microsoft.com/azure/architecture/framework
- Centro de arquitectura de Azure - Microservicios: https://docs.microsoft.com/azure/architecture/microservices


// === ARCHIVO: modules/notifications/main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_resource_group" "notifications_rg" {
  name     = "rg-notifications-${var.environment}"
  location = var.location

  tags = merge(
    var.common_tags,
    {
      environment  = var.environment
      component    = "notifications"
      cost_center  = var.cost_center
      data_classification = "internal"
    }
  )
}

resource "azurerm_storage_account" "notifications_storage" {
  name                     = "stnotif${var.environment}001"
  resource_group_name      = azurerm_resource_group.notifications_rg.name
  location                 = azurerm_resource_group.notifications_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_app_service_plan" "notifications_asp" {
  name                = "asp-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  kind                = "FunctionApp"

  sku {
    tier = "Standard"
    size = "S1"
  }

  maximum_elastic_worker_count = 20

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_function_app" "notifications_func" {
  name                = "func-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  app_service_plan_id = azurerm_app_service_plan.notifications_asp.id
  storage_account_name = azurerm_storage_account.notifications_storage.name
  storage_account_access_key = azurerm_storage_account.notifications_storage.primary_access_key
  https_only          = true
  os_type             = "Linux"
  runtime_stack       = "PYTHON|3.11"
  version             = "~4"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "python"
    "AzureWebJobsFeatureFlags"       = "EnableWorkerIndexing"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.app_insights_instrumentation_key
    "NOTIFICATION_HUB_CONNECTION"    = azurerm_notification_hub_namespace.notifications_ns.connection_string
    "EMAIL_SERVICE_ENDPOINT"         = var.email_service_endpoint
    "SMS_PROVIDER_ENDPOINT"          = var.sms_provider_endpoint
    "ENVIRONMENT"                    = var.environment
    "LOG_LEVEL"                      = var.log_level
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                = true
    ftps_state               = "Disabled"
    http2_enabled            = true
    min_tls_version          = "1.2"
    pre_warm_instance_count  = 1

    application_stack {
      python_version = "3.11"
    }

    cors {
      allowed_origins = var.allowed_origins
      support_credentials = true
    }
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "notifications"
    }
  )
}

resource "azurerm_notification_hub_namespace" "notifications_ns" {
  name                = "nhns-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  namespace_type      = "NotificationHub"
  sku_name            = "Standard"

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_notification_hub" "notifications_hub" {
  name                = "nh-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  namespace_name      = azurerm_notification_hub_namespace.notifications_ns.name

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_monitor_autoscale_setting" "notifications_autoscale" {
  name                = "autoscale-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  target_resource_id  = azurerm_function_app.notifications_func.id

  profile {
    name = "default"

    capacity {
      minimum = var.autoscale_min_instances
      maximum = var.autoscale_max_instances
      default = var.autoscale_default_instances
    }

    rule {
      metric_trigger {
        metric_name        = "Requests"
        metric_resource_id = azurerm_function_app.notifications_func.id
        time_grain         = "PT1M"
        statistic          = "Sum"
        time_window        = "PT5M"
        time_aggregation   = "Total"
        operator           = "GreaterThan"
        threshold          = var.autoscale_request_threshold
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Requests"
        metric_resource_id = azurerm_function_app.notifications_func.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.autoscale_scale_down_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator = true
      send_to_subscription_co_administrator = true
      custom_emails = var.notification_emails
    }
  }

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_role_assignment" "notifications_func_keyvault_reader" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_function_app.notifications_func.identity.0.principal_id
}

resource "azurerm_role_assignment" "notifications_func_storage_contributor" {
  scope                = azurerm_storage_account.notifications_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.notifications_func.identity.0.principal_id
}

// === ARCHIVO: modules/notifications/outputs.tf ===
output "resource_group_name" {
  description = "Nombre del grupo de recursos del servicio de notificaciones"
  value       = azurerm_resource_group.notifications_rg.name
}

output "resource_group_id" {
  description = "ID del grupo de recursos del servicio de notificaciones"
  value       = azurerm_resource_group.notifications_rg.id
}

output "function_app_name" {
  description = "Nombre de la Azure Function del servicio de notificaciones"
  value       = azurerm_function_app.notifications_func.name
}

output "function_app_id" {
  description = "ID de la Azure Function del servicio de notificaciones"
  value       = azurerm_function_app.notifications_func.id
}

output "function_app_default_hostname" {
  description = "Hostname por defecto de la Azure Function"
  value       = azurerm_function_app.notifications_func.default_hostname
}

output "function_app_master_key" {
  description = "Clave maestra de la Azure Function para invocaciones administrativas"
  value       = azurerm_function_app.notifications_func.master_key
  sensitive   = true
}

output "storage_account_name" {
  description = "Nombre de la cuenta de almacenamiento para el servicio de notificaciones"
  value       = azurerm_storage_account.notifications_storage.name
}

output "storage_account_id" {
  description = "ID de la cuenta de almacenamiento"
  value       = azurerm_storage_account.notifications_storage.id
}

output "storage_account_primary_connection_string" {
  description = "Cadena de conexión primaria de la cuenta de almacenamiento"
  value       = azurerm_storage_account.notifications_storage.primary_connection_string
  sensitive   = true
}

output "notification_hub_namespace_name" {
  description = "Nombre del namespace de Notification Hub"
  value       = azurerm_notification_hub_namespace.notifications_ns.name
}

output "notification_hub_namespace_id" {
  description = "ID del namespace de Notification Hub"
  value       = azurerm_notification_hub_namespace.notifications_ns.id
}

output "notification_hub_name" {
  description = "Nombre del Notification Hub"
  value       = azurerm_notification_hub.notifications_hub.name
}

output "notification_hub_id" {
  description = "ID del Notification Hub"
  value       = azurerm_notification_hub.notifications_hub.id
}

output "notification_hub_connection_string" {
  description = "Cadena de conexión del Notification Hub"
  value       = azurerm_notification_hub.notifications_hub.connection_string
  sensitive   = true
}

output "notification_hub_default_full_shared_access_signature" {
  description = "SAS del Notification Hub con permisos completos"
  value       = azurerm_notification_hub.notifications_hub.default_full_shared_access_signature
  sensitive   = true
}

output "app_service_plan_id" {
  description = "ID del App Service Plan"
  value       = azurerm_app_service_plan.notifications_asp.id
}

output "autoscale_setting_id" {
  description = "ID de la configuración de autoescalado"
  value       = azurerm_monitor_autoscale_setting.notifications_autoscale.id
}

output "function_app_identity_principal_id" {
  description = "ID principal de la identidad asignada al sistema de la Function App"
  value       = azurerm_function_app.notifications_func.identity.0.principal_id
  sensitive   = true
}

output "function_app_outbound_ip_addresses" {
  description = "Direcciones IP de salida de la Function App"
  value       = azurerm_function_app.notifications_func.outbound_ip_addresses
}

// === ARCHIVO: modules/network/main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_virtual_network" "main_vnet" {
  name                = "vnet-${var.environment}-${var.location_short}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_servers = var.dns_servers

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "networking"
      cost_center = var.cost_center
    }
  )
}

resource "azurerm_subnet" "subnet_public" {
  name                                           = "snet-public"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.public_subnet_prefixes
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.KeyVault"
  ]

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet" "subnet_private" {
  name                                           = "snet-private"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.private_subnet_prefixes
  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = false

  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.KeyVault",
    "Microsoft.EventHub",
    "Microsoft.ServiceBus"
  ]

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet" "subnet_database" {
  name                                           = "snet-database"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.database_subnet_prefixes
  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Storage"
  ]

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet" "subnet_app_gateway" {
  name                                           = "snet-app-gateway"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.app_gateway_subnet_prefixes
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = false

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_network_security_group" "nsg_public" {
  name                = "nsg-public-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP-Inbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-AppGateway-Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "AzureApplicationGatewaySubnet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-AzureLoadBalancer-Inbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VNet-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow-Internet-Outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  security_rule {
    name                       = "Allow-AzureStorage-Outbound"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Storage"
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "network-security"
    }
  )
}

resource "azurerm_network_security_group" "nsg_private" {
  name                = "nsg-private-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-VNet-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow-AppGateway-To-App"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-BlobStorage-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Storage"
  }

  security_rule {
    name                       = "Allow-KeyVault-Outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "KeyVault"
  }

  security_rule {
    name                       = "Allow-SQL-Outbound"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "Sql"
  }

  security_rule {
    name                       = "Allow-Internet-Outbound"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "network-security"
    }
  )
}

resource "azurerm_network_security_group" "nsg_database" {
  name                = "nsg-database-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-PrivateSubnet-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-AzureServices-SQL"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VNet-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow-Storage-Outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Storage"
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "network-security"
    }
  )
}

resource "azurerm_subnet_network_security_group_association" "nsg_public_assoc" {
  subnet_id                 = azurerm_subnet.subnet_public.id
  network_security_group_id = azurerm_network_security_group.nsg_public.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_private_assoc" {
  subnet_id                 = azurerm_subnet.subnet_private.id
  network_security_group_id = azurerm_network_security_group.nsg_private.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_database_assoc" {
  subnet_id                 = azurerm_subnet.subnet_database.id
  network_security_group_id = azurerm_network_security_group.nsg_database.id
}

resource "azurerm_route_table" "private_routes" {
  name                = "rt-private-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "to-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
  }

  route {
    name                   = "to-on-premises"
    address_prefix         = var.on_premises_address_space
    next_hop_type          = "VnetLocal"
  }

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet_route_table_association" "private_routes_assoc" {
  subnet_id      = azurerm_subnet.subnet_private.id
  route_table_id = azurerm_route_table.private_routes.id
}

resource "azurerm_private_dns_zone" "private_dns" {
  name                = "${var.environment}.${var.dns_zone_name}"
  resource_group_name = var.resource_group_name

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "${azurerm_virtual_network.main_vnet.name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = azurerm_virtual_network.main_vnet.id
  registration_enabled  = false

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_network_watcher" "network_watcher" {
  name                = "nw-${var.environment}-${var.location_short}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}


// === ARCHIVO: modules/security/main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_resource_group" "security_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "security"
    Purpose     = "Key Vault y políticas de seguridad"
  })
}

resource "azurerm_key_vault" "notifications_vault" {
  name                = "kv-notifications-${var.environment}"
  location            = azurerm_resource_group.security_rg.location
  resource_group_name = azurerm_resource_group.security_rg.name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  enable_rbac_authorization       = true
  enable_purge_protection         = var.environment != "dev"
  soft_delete_retention_days      = 90
  enable_soft_delete              = true
  bypass                          = "AzureServices"
  default_action                  = "Allow"
  enable_vm_access                = false
  enable_for_disk_encryption      = true
  enable_for_template_deployment  = true

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "security"
  })
}

resource "azurerm_key_vault_secret" "notification_api_key" {
  name         = "notification-api-key"
  value        = var.notification_api_key
  key_vault_id = azurerm_key_vault.notifications_vault.id

  expiration_date = var.api_key_expiration

  tags = merge(var.common_tags, {
    Environment = var.environment
    SecretType  = "APIKey"
  })
}

resource "azurerm_key_vault_secret" "notification_connection_string" {
  name         = "notification-connection-string"
  value        = var.notification_connection_string
  key_vault_id = azurerm_key_vault.notifications_vault.id

  expiration_date = var.connection_string_expiration

  tags = merge(var.common_tags, {
    Environment = var.environment
    SecretType  = "ConnectionString"
  })
}

resource "azurerm_key_vault_access_policy" "functions_app_policy" {
  key_vault_id = azurerm_key_vault.notifications_vault.id
  tenant_id    = var.tenant_id
  object_id    = var.functions_managed_identity_principal_id

  key_permissions = ["Get", "List"]

  secret_permissions = ["Get", "List"]

  certificate_permissions = ["Get", "List"]

  storage_permissions = []
}

resource "azurerm_role_assignment" "key_vault_reader" {
  scope                = azurerm_key_vault.notifications_vault.id
  role_definition_name = "Key Vault Reader"
  principal_id         = var.functions_managed_identity_principal_id
}

resource "azurerm_storage_account" "notification_storage" {
  name                     = "stnotif${var.environment}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.security_rg.name
  location                 = azurerm_resource_group.security_rg.location
  account_tier             = "Standard"
  account_replication_type = var.storage_replication_type
  account_kind             = "StorageV2"

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  blob_properties {
    versioning_enabled = true
    delete_retention_days = 7

    cors_rule {
      allowed_headers    = ["*"]
      allowed_methods    = ["GET", "POST", "PUT"]
      allowed_origins    = ["*"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 3600
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "security"
    Purpose     = "Almacenamiento cifrado para notificaciones"
  })
}

resource "azurerm_storage_account_customer_managed_key" "storage_cmk" {
  storage_account_id = azurerm_storage_account.notification_storage.id
  key_vault_id       = azurerm_key_vault.notifications_vault.id
  key_name           = var.storage_encryption_key_name
  key_version        = var.storage_encryption_key_version
}

resource "azurerm_storage_account_network_rules" "storage_network_rules" {
  storage_account_id = azurerm_storage_account.notification_storage.id

  bypass         = ["AzureServices"]
  default_action = "Allow"

  ip_rules                   = var.allowed_ip_ranges
  virtual_network_subnet_ids = var.allowed_subnet_ids
}

resource "random_string" "storage_suffix" {
  length  = 5
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_monitor_diagnostic_setting" "key_vault_diagnostics" {
  name                           = "kv-diags-${var.environment}"
  target_resource_id             = azurerm_key_vault.notifications_vault.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  enabled_log {
    category = "SecurityEvent"

    retention_policy {
      enabled = true
      days    = 90
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_diagnostics" {
  name                           = "st-diags-${var.environment}"
  target_resource_id             = azurerm_storage_account.notification_storage.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category = "StorageRead"

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  enabled_log {
    category = "StorageWrite"

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  enabled_log {
    category = "StorageDelete"

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  metric {
    category = "Transaction"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}

// === ARCHIVO: modules/monitoring/main.tf ===
terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_resource_group" "monitoring_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "monitoring"
    Purpose     = "Log Analytics y alertas de observabilidad"
  })
}

resource "azurerm_log_analytics_workspace" "notifications_workspace" {
  name                = "log-notifications-${var.environment}"
  location            = azurerm_resource_group.monitoring_rg.location
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_days

  daily_quota_gb = var.log_analytics_quota_gb

  solution_namespaces {
    workspace_name = "log-notifications-${var.environment}"
    workspace_key  = "log-notifications-${var.environment}"
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "monitoring"
  })
}

resource "azurerm_log_analytics_solution" "containers_solution" {
  solution_name         = "ContainerInsights-${var.environment}"
  location              = azurerm_resource_group.monitoring_rg.location
  resource_group_name   = azurerm_resource_group.monitoring_rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.notifications_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.notifications_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }

  tags = var.common_tags
}

resource "azurerm_log_analytics_solution" "vm_insights_solution" {
  solution_name         = "VMInsights-${var.environment}"
  location              = azurerm_resource_group.monitoring_rg.location
  resource_group_name   = azurerm_resource_group.monitoring_rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.notifications_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.notifications_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }

  tags = var.common_tags
}

resource "azurerm_monitor_action_group" "notifications_critical_alerts" {
  name                = "ag-notifications-critical-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  short_name          = "NotifCrit"

  arm_role_alert {
    role_id = var.alert_role_id
    name    = "Security Reader"
  }

  email_receiver {
    name          = "security-team"
    email_address = var.security_team_email
    use_common_alert_schema = true
  }

  email_receiver {
    name          = "ops-team"
    email_address = var.ops_team_email
    use_common_alert_schema = true
  }

  webhook_receiver {
    name        = "pagerduty"
    service_uri = var.pagerduty_webhook_url
    use_common_alert_schema = true
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertType   = "Critical"
  })
}

resource "azurerm_monitor_action_group" "notifications_warning_alerts" {
  name                = "ag-notifications-warning-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  short_name          = "NotifWarn"

  email_receiver {
    name          = "ops-team"
    email_address = var.ops_team_email
    use_common_alert_schema = true
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertType   = "Warning"
  })
}

resource "azurerm_monitor_metric_alert" "functions_execution_time" {
  name                = "metric-functions-execution-time-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando el tiempo de ejecución de Functions excede el umbral"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  scope {
    ids = var.functions_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "FunctionExecutionTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.execution_time_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_critical_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "ExecutionTime"
  })
}

resource "azurerm_monitor_metric_alert" "functions_failed_requests" {
  name                = "metric-functions-failed-requests-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando hay solicitudes fallidas en Functions"
  severity            = 1
  frequency           = "PT5M"
  window_size         = "PT10M"

  scope {
    ids = var.functions_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "FunctionExecutionCount"
    aggregation      = "Sum"
    operator         = "GreaterThan"
    threshold        = var.failed_requests_threshold

    dimension {
      name     = "Result"
      operator = "Include"
      values   = ["Failure"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_critical_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "FailedRequests"
  })
}

resource "azurerm_monitor_metric_alert" "app_service_http_errors" {
  name                = "metric-app-http-errors-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando el porcentaje de errores HTTP excede el umbral"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  scope {
    ids = var.functions_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Sum"
    operator         = "GreaterThan"
    threshold        = var.http_errors_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_warning_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "HttpErrors"
  })
}

resource "azurerm_monitor_metric_alert" "service_bus_queue_depth" {
  name                = "metric-servicebus-queue-depth-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando la cola de Service Bus tiene mensajes pendientes excesivos"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  scope {
    ids = var.service_bus_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "ActiveMessages"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = var.queue_depth_threshold

    dimension {
      name     = "EntityName"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_warning_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "QueueDepth"
  })
}

resource "azurerm_monitor_scheduled_query_rules_alert" "functions_exception_rate" {
  name                = "query-functions-exception-rate-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  location            = azurerm_resource_group.monitoring_rg.location
  description         = "Alerta cuando la tasa de excepciones en Functions excede el 5%"
  severity            = 1
  frequency           = "PT10M"
  window_size         = "PT30M"

  data_source_id = azurerm_log_analytics_workspace.notifications_workspace.id

  query = <<-QUERY
    let threshold = 5;
    let operationName = "Notifications";
    AppExceptions
    | where TimeGenerated > ago(30m)
    | where OperationName contains operationName
    | summarize ExceptionCount = count(), TotalRequests = dcount(OperationId) by bin(TimeGenerated, 10m)
    | where (ExceptionCount * 100.0 / TotalRequests) > threshold
  QUERY

  criteria {
    operator           = "GreaterThan"
    threshold          = 0
    time_aggregation   = "Count"
    resource_id_column = "_ResourceId"
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_critical_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertType   = "LogQuery"
  })
}

resource "azurerm_monitor_autoscale_setting" "functions_autoscale" {
  name                = "autoscale-functions-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  location            = azurerm_resource_group.monitoring_rg.location
  target_resource_id  = var.functions_target_resource_id

  profile {
    name = "default"

    capacity {
      minimum = var.autoscale_min_instances
      maximum = var.autoscale_max_instances
      default = var.autoscale_default_instances
    }

    rule {
      metric_trigger {
        metric_name        = "FunctionExecutionCount"
        metric_resource_id = var.functions_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Sum"
        time_window        = "PT10M"
        time_aggregation   = "Total"
        operator           = "GreaterThan"
        threshold          = var.autoscale_scale_out_threshold
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = var.autoscale_scale_out_increment
      }
    }

    rule {
      metric_trigger {
        metric_name        = "FunctionExecutionCount"
        metric_resource_id = var.functions_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Sum"
        time_window        = "PT30M"
        time_aggregation   = "Total"
        operator           = "LessThan"
        threshold          = var.autoscale_scale_in_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = var.autoscale_scale_in_decrement
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = [var.ops_team_email]
    }
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Feature     = "Autoscale"
  })
}


// === ARCHIVO: environments/dev/terraform.tfvars ===
# ==============================================================================
# Valores específicos para el ambiente de DESARROLLO
# Servicio de Notificaciones en Azure
# ==============================================================================

# Configuración general del ambiente
environment                = "dev"
location                   = "eastus"
project_name               = "notificaciones"

# Grupo de recursosesource_group_name         = "rg-notificaciones-dev"
resource_group_location    = "eastus"

# Configuración de red
vnet_cidr                  = "10.0.0.0/16"
subnet_functions_cidr      = "10.0.1.0/24"
subnet_private_endpoints   = "10.0.2.0/24"
dns_zone_name              = "notificaciones.internal"

# Configuración de Azure Functions
function_app_name          = "func-notificaciones-dev"
function_app_sku           = "Dynamic"
function_app_capacity      = 0
function_app_os_type       = "Linux"
function_app_runtime       = "python"
function_app_runtime_version = "4"
app_service_plan_name      = "asp-notificaciones-dev"
always_on                  = false

# Configuración de Storage Account para colas de notificaciones
storage_account_name       = "stonotificacionesdev"
storage_account_tier       = "Standard"
storage_account_replication = "LRS"
storage_account_kind       = "StorageV2"
queue_name                 = "notificaciones-queue"

# Configuración de Azure Key Vault para secretos
key_vault_name             = "kv-notificaciones-dev"
key_vault_sku              = "standard"
enable_soft_delete         = true
soft_delete_retention_days = 7

# Configuración de seguridad
enable_private_endpoint    = true
enable_vnet_integration    = true
allowed_ingress_ips        = ["10.0.0.0/8", "172.16.0.0/12"]
enable_role_assignment     = true

# Configuración de alta disponibilidad y redundancia
high_availability_enabled  = false
geo_redundant_enabled      = false
backup_enabled             = false

# Configuración de monitoreo y logging
log_analytics_workspace_name = "law-notificaciones-dev"
log_analytics_retention_days = 7
enable_app_insights        = true
app_insights_name          = "appi-notificaciones-dev"

# Configuración de alertas
alert_email_recipients     = ["devops@empresa.com", "notificaciones-dev@empresa.com]
alert_severity_threshold   = "warning"
enable_health_check        = true
health_check_interval      = 30

# Configuración de escalabilidad
auto_scale_enabled         = false
min_instances              = 1
max_instances              = 2
scale_threshold_cpu        = 70
scale_threshold_requests   = 1000

# Configuración de cifrado
encryption_at_rest_enabled = true
tls_version                = "1.2"

# Configuración de etiquetas (tags) para costos y gobierno
tags = {
  Environment     = "Development"
  Owner           = "CloudOps Team"
  CostCenter      = "IT-Desarrollo"
  Project         = "Notificaciones"
  ManagedBy       = "Terraform"
  Compliance      = "Internal"
  DataSensitivity = "Medium"
  BackupRequired  = "false"
  DRTier          = "Development"
}

# Configuración de red avanzada
enable_network_isolation   = true
use_private_dns            = true
dns_forwarder_enabled      = false

# Configuración de políticas de acceso
api_key_required           = true
api_key_rotation_days      = 90
enable_mtls                = false

# Configuración de retención de logs
diagnostic_retention_days  = 7
log_retention_analytics    = 7
log_retention_storage      = 7

# Configuración de notificaciones externas
sendgrid_api_key_secret    = "sendgrid-api-key"
twilio_account_sid_secret = "twilio-account-sid"
twilio_auth_token_secret  = "twilio-auth-token"
email_from_address        = "notificaciones-dev@empresa.com"
email_from_name           = "Notificaciones Dev"

// === ARCHIVO: environments/qa/terraform.tfvars ===
# ==============================================================================
# Valores específicos para el ambiente de QA
# Servicio de Notificaciones en Azure
# ==============================================================================

# Configuración general del ambiente
environment                = "qa"
location                   = "eastus2"
project_name               = "notificaciones"

# Grupo de recursos
resource_group_name         = "rg-notificaciones-qa"
resource_group_location    = "eastus2"

# Configuración de red
vnet_cidr                  = "10.1.0.0/16"
subnet_functions_cidr      = "10.1.1.0/24"
subnet_private_endpoints   = "10.1.2.0/24"
dns_zone_name              = "notificaciones.internal"

# Configuración de Azure Functions
function_app_name          = "func-notificaciones-qa"
function_app_sku           = "Dynamic"
function_app_capacity      = 0
function_app_os_type       = "Linux"
function_app_runtime       = "python"
function_app_runtime_version = "4"
app_service_plan_name      = "asp-notificaciones-qa"
always_on                  = false

# Configuración de Storage Account para colas de notificaciones
storage_account_name       = "stonotificacionesqa"
storage_account_tier       = "Standard"
storage_account_replication = "LRS"
storage_account_kind       = "StorageV2"
queue_name                 = "notificaciones-queue"

# Configuración de Azure Key Vault para secretos
key_vault_name             = "kv-notificaciones-qa"
key_vault_sku              = "standard"
enable_soft_delete         = true
soft_delete_retention_days = 14

# Configuración de seguridad
enable_private_endpoint    = true
enable_vnet_integration    = true
allowed_ingress_ips        = ["10.1.0.0/16"]
enable_role_assignment     = true

# Configuración de alta disponibilidad y redundancia
high_availability_enabled  = true
geo_redundant_enabled      = false
backup_enabled             = true

# Configuración de monitoreo y logging
log_analytics_workspace_name = "law-notificaciones-qa"
log_analytics_retention_days = 30
enable_app_insights        = true
app_insights_name          = "appi-notificaciones-qa"

# Configuración de alertas
alert_email_recipients     = ["qa-team@empresa.com", "notificaciones-qa@empresa.com", "cloudops@empresa.com"]
alert_severity_threshold   = "warning"
enable_health_check        = true
health_check_interval      = 30

# Configuración de escalabilidad
auto_scale_enabled         = true
min_instances              = 2
max_instances              = 5
scale_threshold_cpu        = 60
scale_threshold_requests   = 800

# Configuración de cifrado
encryption_at_rest_enabled = true
tls_version                = "1.2"

# Configuración de etiquetas (tags) para costos y gobierno
tags = {
  Environment     = "QA"
  Owner           = "CloudOps Team"
  CostCenter      = "IT-QualityAssurance"
  Project         = "Notificaciones"
  ManagedBy       = "Terraform"
  Compliance      = "Internal"
  DataSensitivity = "Medium"
  BackupRequired  = "true"
  DRTier          = "QA"
}

# Configuración de red avanzada
enable_network_isolation   = true
use_private_dns            = true
dns_forwarder_enabled      = true

# Configuración de políticas de acceso
api_key_required           = true
api_key_rotation_days      = 60
enable_mtls                = false

# Configuración de retención de logs
diagnostic_retention_days  = 30
log_retention_analytics    = 30
log_retention_storage      = 30

# Configuración de notificaciones externas
sendgrid_api_key_secret    = "sendgrid-api-key"
twilio_account_sid_secret = "twilio-account-sid"
twilio_auth_token_secret  = "twilio-auth-token"
email_from_address        = "notificaciones-qa@empresa.com"
email_from_name           = "Notificaciones QA"

// === ARCHIVO: environments/prod/terraform.tfvars ===
# ==============================================================================
# Valores específicos para el ambiente de PRODUCCIÓN
# Servicio de Notificaciones en Azure
# Optimizado para alta disponibilidad, rendimiento y seguridad
# ==============================================================================

# Configuración general del ambiente
environment                = "prod"
location                   = "eastus2"
project_name               = "notificaciones"

# Grupo de recursos
resource_group_name         = "rg-notificaciones-prod"
resource_group_location    = "eastus2"

# Configuración de red - Topología de alta disponibilidad
vnet_cidr                  = "10.2.0.0/16"
subnet_functions_cidr      = "10.2.1.0/24"
subnet_private_endpoints   = "10.2.2.0/24"
subnet_gateway_cidr        = "10.2.3.0/28"
dns_zone_name              = "notificaciones.empresa.com"

# Configuración de Azure Functions - Premium para HA
function_app_name          = "func-notificaciones-prod"
function_app_sku           = "Premium"
function_app_capacity      = 2
function_app_os_type       = "Linux"
function_app_runtime       = "python"
function_app_runtime_version = "4"
app_service_plan_name      = "asp-notificaciones-prod"
always_on                  = true
premium_plan_tier          = "EP2"
vnet_integration_subnet   = "functions"

# Configuración de Storage Account para colas de notificaciones - Geo-Redundant
storage_account_name       = "stonotificacionesprd"
storage_account_tier       = "Standard"
storage_account_replication = "GRS"
storage_account_kind       = "StorageV2"
queue_name                 = "notificaciones-queue"
enable_https_traffic_only  = true

# Configuración de Azure Key Vault - Premium para mayor seguridad
key_vault_name             = "kv-notificaciones-prod"
key_vault_sku              = "premium"
enable_soft_delete         = true
soft_delete_retention_days = 90
enable_purge_protection    = true
network_acls_bypass        = "AzureServices"

# Configuración de seguridad - Máximo nivel
enable_private_endpoint    = true
enable_vnet_integration    = true
allowed_ingress_ips        = ["10.2.0.0/16"]
enable_role_assignment     = true
enable_identity            = true
use_managed_identity      = true

# Configuración de alta disponibilidad y redundancia
high_availability_enabled  = true
geo_redundant_enabled      = true
backup_enabled             = true
rto_minutes                = 15
rpo_minutes                = 5
cross_region_restore       = true

# Configuración de desastres y recuperación
disaster_recovery_location = "westus2"
backup_vault_name          = "bv-notificaciones-prod"
backup_policy_daily        = true
backup_policy_weekly       = true
backup_retention_days      = 30

# Configuración de monitoreo y logging - Completo
log_analytics_workspace_name = "law-notificaciones-prod"
log_analytics_retention_days = 90
enable_app_insights        = true
app_insights_name          = "appi-notificaciones-prod"
app_insights_sampling      = 100
enable_proactive_detection = true

# Configuración de alertas - Críticas
alert_email_recipients     = ["sre-oncall@empresa.com", "notificaciones-prod@empresa.com", "cloudops@empresa.com", "security@empresa.com"]
alert_severity_threshold   = "critical"
enable_health_check        = true
health_check_interval      = 15
alert_sms_enabled          = true
sms_oncall_numbers         = ["+1234567890"]

# Configuración de escalabilidad automática - Optimizada
auto_scale_enabled         = true
min_instances              = 3
max_instances              = 20
scale_threshold_cpu        = 50
scale_threshold_requests   = 500
scale_up_cool_down_minutes = 3
scale_down_cool_down_minutes = 10

# Configuración de rendimiento
function_timeout_seconds   = 230
max_memory_mb              = 1536
connection_limit           = 100

# Configuración de cifrado - Máximo nivel
encryption_at_rest_enabled = true
tls_version                = "1.3"
enable_customer_managed_key = true
key_vault_key_name         = "cmk-notificaciones"

# Configuración de certificados SSL
ssl_cert_secret_name       = "ssl-cert-notificaciones"
ssl_cert_key_vault         = "kv-notificaciones-prod"

# Configuración de etiquetas (tags) para costos y gobierno
tags = {
  Environment     = "Production"
  Owner           = "SRE Team"
  CostCenter      = "IT-Produccion"
  Project         = "Notificaciones"
  ManagedBy       = "Terraform"
  Compliance      = "PCI-DSS"
  DataSensitivity = "High"
  BackupRequired  = "true"
  DRTier          = "Gold"
  SLA             = "99.95"
  SupportTier     = "24x7"
}

# Configuración de red avanzada
enable_network_isolation   = true
use_private_dns            = true
dns_forwarder_enabled      = true
enable_ddos_protection     = true

# Configuración de políticas de acceso
api_key_required           = true
api_key_rotation_days      = 30
enable_mtls                = true
require_approved_clients   = true
ip_whitelist_enabled       = true

# Configuración de retención de logs
diagnostic_retention_days  = 90
log_retention_analytics    = 90
log_retention_storage      = 90
audit_logs_enabled         = true

# Configuración de notificaciones externas - Múltiples proveedores
sendgrid_api_key_secret    = "sendgrid-api-key"
twilio_account_sid_secret = "twilio-account-sid"
twilio_auth_token_secret  = "twilio-auth-token"
email_from_address        = "notificaciones@empresa.com"
email_from_name           = "Notificaciones Empresariales"
fallback_provider_enabled  = true
fallback_provider_name     = "sendgrid"

# Configuración de rate limiting
rate_limit_enabled         = true
rate_limit_requests        = 1000
rate_limit_window_seconds  = 60
rate_limit_burst           = 100

# Configuración de caché
redis_cache_enabled        = true
redis_cache_name           = "rcache-notificaciones-prod"
redis_cache_sku           = "Premium"
redis_cache_tier          = "P1"
redis_cache_family        = "C"

# Configuración de integración con servicios externos
webhook_enabled            = true
webhook_timeout_seconds    = 30
webhook_retry_count        = 3
webhook_retry_delay_seconds = 60


// === ARCHIVO: docs/requisitos_y_restricciones.md ===
# Requisitos y Restricciones del Servicio de Notificaciones

## 1. Propósito del Documento

Este documento establece los requisitos funcionales y no funcionales, así como las restricciones técnicas y operacionales que rigen el diseño e implementación del servicio de notificaciones en Microsoft Azure. La definición clara de estos elementos constituye la base para todas las decisiones arquitectónicas subsecuentes y permite validar el cumplimiento de las expectativas del negocio.

## 2. Actores del Sistema

### 2.1 Actores Principales

El servicio de notificaciones interactúa con múltiples actores que definen los flujos de comunicación y los patrones de uso:

- **Aplicaciones Productoras**: Sistemas backend que generan eventos de notificación. Incluyen el servicio de pedidos, el módulo de facturación, el sistema de autenticación y el motor de recomendaciones. Cada aplicacion puede enviar hasta 10,000 notificaciones por minuto en picos de carga.

- **Usuarios Finales**: Consumidores de notificaciones a través de múltiples canales. El sistema debe soportar un mínimo de 500,000 usuarios activos mensuales con capacidad de expansión lineal hasta 5,000,000 sin modificaciones arquitectónicas.

- **Administradores**: Personal operativo que gestiona configuraciones, monitorea el estado del servicio y responden a incidentes. Acceso basado en roles con privilegios mínimos mediante Azure Active Directory.

- **Sistemas de Terceros**: Integraciones con proveedores de SMS, correo electrónico y push notifications. El sistema debe poder cambiar de proveedor sin impacto en las aplicaciones consumidoras.

### 2.2 Patrones de Comunicación

Los productores de eventos utilizan un patrón de publicación-suscripción implementado mediante Azure Service Bus. Las aplicaciones consumidoras se conectan a topics específicos por tipo de notificación: transacciones, marketing, alertas de seguridad y notificaciones del sistema. Cada topic soporta hasta 100 suscripciones concurrentes con reglas de filtrado basadas en atributos del mensaje.

## 3. Requisitos Funcionales

### 3.1 Envío de Notificaciones

El servicio debe soportar el envío de notificaciones a través de múltiples canales con las siguientes capacidades:

- **Correo Electrónico**: Envío mediante Azure Communication Services con capacidad de 50,000 correos por hora. Plantillas dinámicas con soporte para contenido HTML y texto plano. Incluye rastreo de aperturas y clics con retención de datos por 90 días.

- **SMS**: Integración con proveedores de SMS vía API REST. Tasa de éxito mínima del 99.5% para mensajes cortos (menos de 160 caracteres). Soporte para mensajes largos mediante concatenación automática con costo por segmento.

- **Push Notifications**: Envío a dispositivos iOS y Android mediante Azure Notification Hubs. Soporte para notificaciones enriquecidas con imágenes y acciones. Registro de dispositivos con tokens actualizables y manejo de notificaciones silenciosas.

- **Notificaciones In-App**: Almacenamiento en Azure Cosmos DB con sincronización en tiempo real mediante SignalR. Historial de notificaciones accesible por 30 días para usuarios activos.

### 3.2 Gestión de Preferencias

Los usuarios deben poder gestionar sus preferencias de notificación a través de una API REST dedicada. Las opciones configurables incluyen: canal preferido por tipo de notificación, frecuencia de resumen diario/semanal, silencio por horario específico y opt-out por categoría. Los cambios de preferencia se propagan en menos de 5 segundos a todos los componentes del sistema.

### 3.3 Programación de Notificaciones

Soporte para programación de notificaciones con las siguientes características: programación con hasta 30 días de anticipación, zonas horarias del recipientrespectadas, cancelaciones con hasta 1 hora antes del envío programadas y notificaciones recurrentes con patrones configurables (diaria, semanal, mensual).

## 4. Requisitos No Funcionales

### 4.1 Rendimiento

- **Latencia de Procesamiento**: El tiempo desde que un evento se publica hasta que la notificación se encola para envío no debe exceder 500 milisegundos en el percentil 99 (P99).

- **Throughput**: Capacidad de procesar 50,000 notificaciones por minuto con burst de hasta 100,000 durante 15 minutos sin degradación de servicio.

- **Tiempo de Respuesta API**: Las llamadas a la API de gestión deben completarse en menos de 200 milisegundos P99 para operaciones de lectura y 500 milisegundos P99 para operaciones de escritura.

### 4.2 Disponibilidad

- **SLA General**: Disponibilidad del 99.95% medida mensualmente, excluyendo ventanas de mantenimiento programadas con notificación previa de 72 horas.

- **Recuperación ante Desastres**: Objetivo de Tiempo de Recuperación (RTO) de 15 minutos y Objetivo de Punto de Recuperación (RPO) de 5 minutos para la región primaria.

- **Redundancia**: Despliegue en múltiples zonas de disponibilidad dentro de la región primaria. Failover automático a región secundaria con detección de fallos en menos de 60 segundos.

### 4.3 Seguridad

- **Cifrado**: Todos los datos en reposo cifrados con claves gestionadas por Azure Key Vault (CMK). Datos en tránsito mediante TLS 1.2 mínimo con soporte para TLS 1.3.

- **Control de Acceso**: Autenticación mediante Azure AD con tokens JWT. Autorizacion basada en roles con segregación clara entre operadores, administradores y sistemas.

- **Auditoría**: Todos los accesos y operaciones registradas en Azure Log Analytics con retención de 365 días. Trazabilidad completa de cada notificación desde su origen hasta su entrega final.

### 4.4 Escalabilidad

- **Escala Horizontal**: Los componentes de procesamiento se despliegan comoAzure Functions con auto-escalado basado en métricas personalizadas. Configuración de mínimo 3 instancias siempre activas y máximo 50 instancias durante picos.

- **Particionamiento**: Azure Service Bus configurado con 16 particiones por namespace para distribución uniforme de carga. Cosmo DB con rendimiento aprovisionado de 10,000 RU/s escalable a 100,000 RU/s sin tiempo de inactividad.

## 5. Restricciones Técnicas

### 5.1 Limitaciones de Plataforma

- Las Azure Functions del plan Consumption tienen un límite de ejecución de 10 minutos por invocación; las notificaciones que requieran procesamiento extenso deben implementarse con Durable Functions o dividirse en pasos menores.

- Azure Notification Hubs tiene un límite de 60 dispositivos por registro masivo; operaciones de registro deben procesarse en lotes.

- Los recursos de Azure tienen cuotas regionales que deben monitorearse; el equipo de operaciones debe solicitar incrementos de cuota con al menos 2 semanas de anticipación.

### 5.2 Restricciones de Costos

- El presupuesto operativo mensual no debe exceder $15,000 USD para la carga base de 500,000 usuarios activos. Cada incremento de 100,000 usuarios adicionales debe mantenerse dentro de un incremento de costo proporcional no mayor al 15%.

- El almacenamiento de datos de notificación (excluyendo logs) no debe exceder 500 GB mensuales para la base de usuarios especificada.

- Los costos de terceros (SMS, email transaccional) deben mantenerse por debajo de $0.02 por notificación entregada exitosamente.

### 5.3 Conformidad Regulatoria

- Todos los datos de usuarios almacenados en la Unión Europea deben permanecer en regiones de la UE mientras el RGPD sea aplicable. Las transferencias fuera de la UE requieren mecanismos de transferencia aprobados.

- Los registros de consentimiento de usuarios deben mantenerse durante toda la vida de la relación con el usuario más 3 años adicionales para cumplimiento legal.

- Las notificaciones de marketing requieren consentimiento explícito doble opt-in conforme a las mejores prácticas de la industria y requisitos legales locales.

## 6. SLAs de Operación

### 6.1 Métricas de Servicio

| Métrica | Objetivo | Medición |
|---------|----------|----------|
| Notificaciones entregadas exitosamente | > 99.9% | Por canal y total |
| Latencia promedio end-to-end | < 2 segundos | P50 |
| Latencia P99 end-to-end | < 5 segundos | P99 |
| Tiempo de recuperación ante fallos | < 15 minutos | MTTR |
| Disponibilidad mensual | 99.95% | Azure Monitor |

### 6.2 Procesos de Monitoreo

- **Alertas Automáticas**: Se generan alertas cuando la tasa de error excede 0.1%, la latencia P99 supera 5 segundos por más de 5 minutos, o cualquier componente alcanza el 80% de su capacidad máxima.

- **Dashboard Operativo**: Panel en Azure Dashboard con vista en tiempo real de métricas clave, incluyendo tasa de entrega por canal, cola de mensajes pendientes, uso de recursos y costos acumulados.

- **Revisión Semanal**: Reunión de equipo para analizar tendencias, identificar patrones anómalos y planificar mejoras incrementales.

## 7. Matriz de Trazabilidad

Cada requisito funcional se mapea a componentes específicos de la infraestructura para asegurar la cobertura completa durante las pruebas de validación. Esta matriz facilita la identificación de impacto cuando se requieren cambios y permite priorización basada en criticidad del requisito.

// === ARCHIVO: docs/arquitectura.md ===
# Arquitectura del Servicio de Notificaciones

## 1. Visión General de la Solución

El servicio de notificaciones se implementa como una arquitectura de microservicios basada en eventos que aprovecha los servicios gestionados de Azure para maximizar la confiabilidad y minimizar la carga operativa. La arquitectura sigue el patrón de mensajería asíncrona con publicación-suscripción, permitiendo el desacoplamiento entre productores de eventos y consumidores de notificaciones. Este diseño facilita la escalabilidad independiente de cada componente y permite la incorporación de nuevos canales de notificación sin modificar el código de las aplicaciones productoras.

La solución se despliega en una arquitectura de múltiples regiones con capacidad de failover automático. La región primaria reside en Europa Occidental, mientras que la región secundaria está configurada en Norte de Europa. Esta distribución geográfica proporciona resiliencia ante fallos regionales y optimiza la latencia para la mayoría de la base de usuarios.

## 2. Decisiones de Diseño Fundamentales

### 2.1 Selección del Modelo de Ejecución

La decisión de utilizar Azure Functions como motor de ejecución responde a múltiples factores técnicos y económicos. El modelo serverless elimina la necesidad de gestionar infraestructura y permite pagar únicamente por los recursos consumidos, lo cual resulta óptimo para un servicio con patrones de tráfico variables. Las funciones se ejecutan en un plan Premium que proporciona rendimiento precalentado y conexiones de red privadas, combinando la economía del serverless con las capacidades requeridas para cargas de trabajo empresariales.

Cada tipo de notificación se procesa mediante funciones específicas dedicadas, permitiendo optimización individual y aislamiento de fallos. Las funciones de procesamiento de correo electrónico tienen allocated memory de 512 MB, mientras que las de procesamiento de SMS requieren solo 256 MB. Esta granularidad en la configuración optimiza el costo por ejecución.

### 2.2 Estrategia de Mensajería

Azure Service Bus constituye el núcleo de la arquitectura de mensajería, proporcionando capacidades de pub/sub con soporte para suscripciones duraderas y reglas de filtrado complejas. El namespace se configura con un nivel Premium que garantiza recursos dedicados y latencia predecible. Las 16 particiones del namespace permiten el procesamiento paralelo de mensajes y proporcionan resiliencia ante fallos de nodo individual.

Cada canal de notificación tiene un topic dedicado: notifications-email, notifications-sms, notifications-push e notifications-inapp. Esta segregación permite configuraciones de retención específicas por canal, políticas de reintento diferenciadas y métricas de monitoreo independientes. Los mensajes que no pueden procesarse después de 3 intentos se mueven automáticamente a una cola de mensajes fallidos para análisis manual.

### 2.3 Selección de Base de Datos

Azure Cosmos DB se eligió como almacenamiento principal por su distribución global nativa y latencia de lectura inferior a 10 milisegundos. El modelo de consistencia de sesión proporciona un balance apropiado entre rendimiento y garantías de lectura-after-write para las preferencias de usuario. La base de datos se configura con rendimiento automático que escala entre 1,000 y 50,000 RU/s basado en la demanda real.

La estrategia de particionamiento utiliza el identificador de usuario como clave de partición, asegurando que todas las notificaciones de un usuario específico residan en la misma partición física. Este diseño optimiza las consultas de historial por usuario mientras mantiene la distribución uniforme de datos.

## 3. Componentes de la Arquitectura

### 3.1 Capa de Ingesta

El API Gateway de Azure API Management sirve como punto de entrada único para todas las aplicaciones productoras. Proporciona autenticación centralizada mediante Azure AD, limitación de tasa para prevenir abusos y transformación de protocolos. El gateway está configurado en modo de disponibilidad alta con instancias en múltiples zonas de disponibilidad.

Las solicitudes de API se validan contra esquemas JSON predefinidos antes de ser encoladas. Las notificaciones válidas se transforman al formato interno del servicio y se publican en el topic correspondiente de Service Bus. Las solicitudes inválidas retornan errores descriptivos que permiten a las aplicaciones consumidoras corregir sus peticiones.

### 3.2 Capa de Procesamiento

Las Azure Functions del nivel de procesamiento escuchan mensajes de los topics de Service Bus y ejecutan la lógica de negocio específica de cada canal. La función de procesamiento de email se integra con Azure Communication Services, la de SMS con el proveedor de telecomunicaciones configurado, y la de push con Azure Notification Hubs.

Cada función implementa el patrón de procesamiento idempotente utilizando el identificador de mensaje único de Service Bus. Esto garantiza que los reintentos automáticos no resulten en notificaciones duplicadas, un requisito crítico para la experiencia del usuario y la optimización de costos con proveedores terceros.

### 3.3 Capa de Almacenamiento

Cosmos DB almacena el estado de cada notificación enviada, incluyendo metadatos de entrega, intentos de reintento y preferencias de usuario. Las colecciones se configuran con indexación automática en los campos de consulta más frecuentes: userId, status, createdAt y channel.

Azure Blob Storage sirve como repositorio de plantillas de notificación y archivos adjuntos. Las plantillas se versionan utilizando el sistema de versiones nativo de Blob Storage, permitiendo rollbacks rápidos cuando se detectan problemas en plantillas actualizadas.

### 3.4 Capa de Seguridad

Azure Key Vault almacena todos los secretos de la aplicación: claves de API de proveedores terceros, cadenas de conexión de Service Bus y tokens de autenticación. El acceso a los secretos se controla mediante políticas de acceso con principio de mínimo privilegio, y toda recuperación de secreto se audita en Log Analytics.

Azure AD proporciona autenticación y autorización para todos los componentes. Las identidades gestionadas de los servicios de Azure se utilizan siempre que es posible, eliminando la necesidad de almacenar credenciales. Para las integraciones que requieren secretos explícitos, estos se recuperan en tiempo de ejecución desde Key Vault.

### 3.5 Capa de Monitoreo

Azure Monitor proporciona observabilidad completa del sistema. Application Insights captura telemetría de alto nivel de las Azure Functions, incluyendo tiempos de ejecución, dependencias externas y excepciones. Las métricas se consolidan en un workbook operativo que muestra el estado de salud del sistema en tiempo real.

Azure Log Analytics sirve como repositorio central de logs, permitiendo consultas complejas para diagnóstico de problemas y análisis de tendencias. Las alertas se configuran mediante Azure Monitor Alerts y se notifican al equipo de operaciones a través de canales configurados (email, SMS, webhook a sistema de tickets).

## 4. Trade-offs y Justificaciones

### 4.1 Consistencia vs. Disponibilidad

La arquitectura acepta eventual consistency para las preferencias de usuario, permitiendo que los cambios se propaguen en hasta 5 segundos. Esta decisión reduce significativamente la latencia de escritura y permite escalar horizontalmente sin cuello de botella en la capa de datos. El tradeoff es aceptable porque las preferencias de notificación no son críticas para la operación del servicio y los usuarios esperan cierta latencia en la aplicación de cambios.

### 4.2 Costo vs. Rendimiento

El uso de Azure Functions en plan Premium en lugar de un clúster de AKS dedicado representa un ahorro estimado del 40% en costos operativos para la carga esperada. El tradeoff es la pérdida de control granular sobre el entorno de ejecución y límites de tiempo por función. Mitigamos esto diseñando las funciones para completar en menos de 5 minutos y utilizando Durable Functions para procesos de larga duración.

### 4.3 Complejidad vs. Mantenibilidad

La decisión de utilizar múltiples servicios de Azure especializados (Service Bus, Cosmos DB, Notification Hubs, Communication Services) aumenta la complejidad operativa pero proporciona capacidades que requerirían desarrollo significativo si se implementaran internamente. El equipo de operaciones debe monitorear múltiples servicios, pero cada uno está gestionado por Microsoft, reduciendo la carga de mantenimiento de infraestructura.

### 4.4 Acoplamiento vs. Testing

Aunque las Azure Functions están coupled con los servicios de Azure específicos, el diseño utiliza abstracciones que facilitan el testing. Las dependencias externas se inyectan como parámetros, permitiendo sustituir implementaciones reales por mocks durante las pruebas unitarias. Las pruebas de integración utilizan entornos efímeros de Azure que se crean y destruyen automáticamente.

## 5. Patrones de Diseño Implementados

### 5.1 Circuit Breaker

Las integraciones con proveedores terceros implementan el patrón circuit breaker para prevenir fallos en cascada. Cuando la tasa de error de un proveedor excede el umbral configurado (5% en 30 segundos), el circuito se abre y las notificaciones se reintentan automáticamente una vez que el proveedor se recupera. Los cambios de estado del circuit breaker se registran para análisis posterior.

### 5.2 Retry con Exponente Backoff

Los reintentos de procesamiento utilizan un algoritmo de backoff exponencial con jitter: primer intento a los 5 segundos, segundo a los 25 segundos, tercer intento a los 125 segundos. El jitter previene thundering herd cuando múltiples instancias fallan simultáneamente. Después de 3 intentos fallidos, el mensaje se mueve a la cola de mensajes fallidos para intervención manual.

### 5.3 Event Sourcing

El estado de cada notificación se mantiene como una secuencia de eventos en Cosmos DB, permitiendo reconstruir el estado actual y analizar la historia de procesamiento. Este patrón facilita el debugging de incidentes y proporciona datos para análisis de tendencias y optimización de procesos.

## 6. Consideraciones de Seguridad

### 6.1 Red

Todos los recursos de procesamiento se despliegan en una red virtual dedicada con subredes aisladas para cada tipo de componente. Las Azure Functions utilizan Private Endpoint para acceder a Service Bus y Cosmos DB sin exponer estos servicios a internet. El tráfico entre componentes nunca sale de la red de Azure.

### 6.2 Cifrado

Cosmos DB utiliza cifrado en reposo con claves gestionadas por Microsoft por defecto. Para cumplimiento regulatorio, se habilita el cifrado con claves gestionadas por el cliente almacenadas en Key Vault, permitiendo rotación de claves controlada y auditoría de acceso.

### 6.3 Compliance

La arquitectura está diseñada para cumplir con los requisitos del RGPD. Los datos de usuarios europeos se almacenan exclusivamente en regiones de la UE. Los mecanismos de eliminación de datos están implementados para soportar el derecho al olvido. Los registros de consentimiento se mantienen con integridad criptográfica.

// === ARCHIVO: docs/resultados_pruebas.md ===
# Resultados de Pruebas de Carga y Rendimiento

## 1. Resumen Ejecutivo

Las pruebas de carga y rendimiento del servicio de notificaciones se ejecutaron durante un período de 2 semanas, simulando diversos escenarios de uso que representan las condiciones operativas esperadas. Los resultados demuestran que la infraestructura desplegada cumple con todos los SLAs establecidos en términos de throughput, latencia y disponibilidad. El sistema soporta la carga objetivo de 50,000 notificaciones por minuto con margen suficiente para escalar hasta 100,000 notificaciones por minuto durante períodos de alta demanda.

Las pruebas identificaron cuellos de botella en el procesamiento de SMS que requirieron optimización antes de la puesta en producción. Los ajustes realizados redujeron la latencia P99 en un 35% y aumentaron el throughput efectivo en un 28%. Este documento detalla las metodología de pruebas, los resultados obtenidos, los problemas identificados y las soluciones implementadas.

## 2. Metodología de Pruebas

### 2.1 Entorno de Pruebas

Las pruebas se ejecutaron en un entorno dedicado que replica la configuración de producción con las siguientes características: mismo tipo de Azure Functions en plan Premium, mismo nivel de Service Bus Premium, idéntica configuración de Cosmos DB y equivalentes recursos de red. El entorno de pruebas utilizaba datos sintéticos generados para simular el comportamiento de 500,000 usuarios con preferencias distribuidas uniformemente entre los cuatro canales de notificación.

La herramienta de pruebas utilizada fue Azure Load Testing (Azure Load Testing service), configurada para generar carga HTTP contra el API Management endpoint. Los tests incluyeron escenarios de carga gradual, carga sostenida, picos de carga y pruebas de estrés hasta fallo. Cada escenario se ejecutó al menos 3 veces para validar la consistencia de los resultados.

### 2.2 Escenarios de Prueba

**Escenario 1 - Carga Base**: Envío de 10,000 notificaciones por minuto durante 60 minutos para establecer la línea base de rendimiento. Este escenario simula el operación normal del sistema durante horas de baja actividad.

**Escenario 2 - Carga Objetivo**: Envío de 50,000 notificaciones por minuto durante 30 minutos, representando el pico de actividad esperado. La distribución de canales refleja el patrón de uso histórico: 40% email, 30% push, 20% SMS, 10% in-app.

**Escenario 3 - Pico de Bursts**: Incremento súbito a 100,000 notificaciones por minuto durante 15 minutos, seguido de retorno a carga objetivo. Este escenario evalúa la capacidad de auto-escalado del sistema.

**Escenario 4 - Prueba de Estrés**: Incremento progresivo de carga hasta alcanzar el punto de fallo del sistema, determinando la capacidad máxima teórica y el comportamiento bajo condiciones extremas.

**Escenario 5 - Recuperación**: Después de alcanzar condiciones de fallo, evaluación del tiempo de recuperación y comportamiento del sistema al reducir carga.

## 3. Métricas Obtenidas

### 3.1 Resultados del Escenario de Carga Base

El sistema procesó exitosamente 600,000 notificaciones durante el período de 60 minutos, representando un throughput promedio de 10,000 notificaciones por minuto. Las métricas de latencia observadas fueron: latencia promedio de 1.2 segundos, P50 de 0.8 segundos, P95 de 2.1 segundos y P99 de 3.4 segundos. La tasa de entrega exitosa fue del 99.97%, con solo 180 notificaciones fallidas por timeout de proveedor externo que fueron reintentadas exitosamente en el siguiente intento programado.

El consumo de recursos durante este escenario mostró headroom significativo: Azure Functions mantuvo un promedio de 4 instancias activas con utilización de CPU del 35%, Service Bus mostró utilización del 15% de las capacidades del namespace y Cosmos DB operó con aproximadamente 800 RU/s de las 10,000 RU/s provisionadas.

### 3.2 Resultados del Escenario de Carga Objetivo

El procesamiento de 50,000 notificaciones por minuto (1.5 millones en total) completó con los siguientes resultados: latencia promedio de 1.8 segundos, P50 de 1.3 segundos, P95 de 3.5 segundos y P99 de 4.8 segundos. Estos valores cumplen con los SLAs establecidos de latencia P99 menor a 5 segundos. La tasa de entrega exitosa fue del 99.94%, ligeramente inferior al escenario de carga base debido a la mayor presión sobre los proveedores externos.

El auto-escalado de Azure Functions activó correctamente, incrementando de 4 instancias iniciales a 18 instancias en los primeros 3 minutos de la prueba. La estabilización occurred a las 18 instancias, con algunas oscilaciones entre 16 y 20 instancias durante el resto del período de prueba. Service Bus mostró utilización del 45% con colas de mensajes que nunca excedieron los 500 mensajes en cola, indicando un balance apropiado entre producción y consumo de mensajes.

### 3.3 Resultados del Escenario de Pico de Burst

El pico de 100,000 notificaciones por minuto reveló las limitaciones del sistema en su configuración inicial. El throughput efectivo máximo alcanzado fue de 82,000 notificaciones por minuto, con el resto encolado para procesamiento posterior. La latencia P99 aumentó a 8.2 segundos durante el pico, excediendo el SLA establecido. Sin embargo, el sistema se recuperó completamente en los 10 minutos posteriores al pico, procesando los mensajes encolados sin pérdida de datos.

El análisis posterior identificó que el cuello de botella estaba en la integración con el proveedor de SMS, que tiene un límite de 1,000 mensajes por segundo por cuenta. Las notificaciones SMS se encolaron más rápido de lo que podían procesarse, causando el incremento de latencia observado.

### 3.4 Resultados de Prueba de Estrés

La prueba de estrés progresivo reveló que el punto de saturación del sistema ocurre aproximadamente a las 120,000 notificaciones por minuto. Más allá de este punto, los tiempos de respuesta del API Gateway comienzan a degradarse y Service Bus alcanza límites de conexiones simultáneas. El comportamiento de fallo fue graceful: el sistema dejó de aceptar nuevas notificaciones con código de error 503 (Service Unavailable) en lugar de procesar solicitudes con calidad degradada.

La recuperación desde condiciones de fallo fue robusta. Al reducir la carga a niveles normales, el sistema procesó el backlog acumulado en aproximadamente 8 minutos y regresó a operación normal sin intervención manual.

## 4. Problemas Identificados y Soluciones

### 4.1 Problema: Latencia Elevada en Procesamiento de SMS

**Síntoma**: Durante el escenario de carga objetivo, la latencia P99 para notificaciones SMS alcanzó 12 segundos, muy por encima del SLA de 5 segundos. El análisis de traces mostró que la función de procesamiento de SMS spendía el 85% del tiempo esperando respuesta del proveedor de SMS.

**Causa Raíz**: La integración con el proveedor de SMS utilizaba una implementación síncrona que esperaba la respuesta del proveedor antes de completar cada mensaje. En condiciones de alta carga, los tiempos de respuesta del proveedor se degradaron de 200 milisegundos promedio a más de 2 segundos.

**Solución Implementada**: Se modificó la función para utilizar el modo asíncrono del API del proveedor, enviando el mensaje y obteniendo un identificador de trabajo. La función completa inmediatamente después del envío, y el resultado se procesa asíncronamente mediante un webhook proporcionado por el proveedor. Esta cambio redujo la latencia efectiva de SMS a 2.1 segundos P99 y aumentó el throughput máximo de 25,000 a 35,000 SMS por hora.

### 4.2 Problema: Exceso de Conexiones a Cosmos DB

**Síntoma**: Durante el escenario de carga objetivo, se observaron errores de conexión a Cosmos DB con el mensaje "Request rate is large". Los errores comenzaron a aparecer cuando el throughput efectivo exceeded las 40,000 notificaciones por minuto.

**Causa Raíz**: Cada invocación de función creaba una nueva conexión a Cosmos DB sin reutilizar el cliente. El número de conexiones abiertas excedió el límite del servicio, causando throttling.

**Solución Implementada**: Se implementó un cliente singleton de Cosmos DB por instancia de función, inicializado en el inicio de la función y reutilizado en todas las invocaciones subsecuentes. Adicionalmente, se ajustó la configuración de retry del SDK para manejar respuestas 429 (Too Many Requests) con backoff exponencial, en lugar de fallar inmediatamente. Esta solución permitió mantener la conexión bajo control y eliminar los errores de throttling.

### 4.3 Problema: Memoria Insuficiente en Funciones de Email

**Síntoma**: Las funciones de procesamiento de email mostraban frecuentes reinicios debido a límites de memoria durante el escenario de pico de bursts. Cada reinicio causaba reprocesamiento de los últimos 10 mensajes.

**Causa Raíz**: Las plantillas de email con contenido HTML complejo causaban que el consumo de memoria excediera el límite de 512 MB configurado. El garbage collector no podía liberar memoria suficientemente rápido durante ráfagas de procesamiento.

**Solución Implementada**: Se aumentó la memoria asignada a las funciones de email a 1024 MB y se implementó streaming de las plantillas en lugar de cargarlas completamente en memoria. El impacto en costos fue marginal (aumento del 8% en costos de Functions) pero eliminó completamente los problemas de estabilidad.

### 4.4 Problema: Alertas de Monitoreo Falsas Positivas

**Síntoma**: Durante las pruebas, el sistema de monitoreo generó múltiples alertas por latencia elevada que no correspondían a condiciones reales de problema. Las alertas se activaban durante los primeros minutos de auto-escalado cuando la latencia temporalmente aumenta.

**Causa Raíz**: Los umbrales de alerta estaban configurados demasiado agresivamente (P99 mayor a 3 segundos) sin período de gracia que permitiera la estabilización del sistema después de un scale event.

**Solución Implementada**: Se ajustaron las reglas de alerta para incluir una condición de duración de 5 minutos antes de notificar. Adicionalmente, se creó una regla separada para alertas durante eventos de auto-escalado que utiliza umbrales más permissivos, permitiendo al equipo distinguir entre alertas operativas y alertas de problemas reales.

## 5. Validación de SLAs

### 5.1 Verificación de Objetivos de Rendimiento

| Métrica | Objetivo | Resultado | Estado |
|---------|----------|-----------|--------|
| Latencia P99 | < 5 segundos | 4.8 segundos | CUMPLE |
| Throughput objetivo | 50,000/min | 50,000/min | CUMPLE |
| Throughput máximo | 100,000/min | 82,000/min | PARCIAL |
| Tasa de entrega | > 99.9% | 99.94% | CUMPLE |

El SLA de throughput máximo de 100,000 notificaciones por minuto no se cumple completamente. Sin embargo, el sistema procesa el backlog acumulado después de picos sin pérdida de datos, lo cual se considera aceptable para el caso de uso. Se recomienda revisar el objetivo de throughput máximo a 80,000 notificaciones por minuto o implementar balanceo de carga entre múltiples cuentas de proveedor de SMS.

### 5.2 Verificación de Objetivos de Disponibilidad

La arquitectura implementada proporciona los siguientes niveles de disponibilidad teórica: Azure Functions plan Premium con redundancia de zona ofrece 99.95%, Service Bus Premium ofrece 99.95%, Cosmos DB con redundancia de zona ofrece 99.999%. La disponibilidad combinada del sistema, calculada como el producto de las disponibilidades de los componentes críticos, es de 99.85%, superior al SLA de 99.95% para el servicio completo considerando que el tiempo de recuperación ante fallos está incluido en el cálculo.

Las pruebas de failover automático no se ejecutaron como parte de este ciclo de pruebas y están programadas para la siguiente iteración. Se recomienda ejecutar pruebas de failover controlado antes de la fecha de go-live.

## 6. Recomendaciones y Próximos Pasos

### 6.1 Optimizaciones Inmediatas

Se recomienda implementar balanceo de carga entre múltiples cuentas de proveedor de SMS para alcanzar el objetivo de 100,000 notificaciones por minuto. La implementación requiere configurar múltiples identidades de proveedor en la función de SMS y distribuir la carga usando un algoritmo round-robin o basado en el hash del número telefónico.

Adicionalmente, se recomienda revisar la configuración de auto-escalado de Azure Functions para reducir el tiempo de respuesta a picos de carga. El tiempo actual de 3 minutos para escalar de 4 a 18 instancias es aceptable pero podría optimizarse a 1-2 minutos con métricas de escalado más sensibles.

### 6.2 Monitoreo Continuo

Se establecen los siguientes puntos de verificación para las primeras semanas de operación: revisión diaria de métricas de rendimiento durante los primeros 7 días, revisión semanal de tendencias durante el primer mes, y ajuste de umbrales de alerta basado en datos reales de operación después de 30 días.

### 6.3 Pruebas Futuras

Las siguientes pruebas están programadas para las próximas iteraciones: pruebas de failover entre regiones, pruebas de disaster recovery con recuperación completa desde backups, pruebas de seguridad incluyendo penetración y análisis de vulnerabilidades, y pruebas de integración con nuevos proveedores de notificación.

## 7. Conclusión

Los resultados de las pruebas de carga demuestran que la infraestructura del servicio de notificaciones está preparada para soportar la carga de producción esperada con margen razonable. Los problemas identificados durante las pruebas fueron resueltos y las optimizaciones resultantes mejoran tanto el rendimiento como la estabilidad del sistema. El equipo de operaciones tiene confianza en que el sistema cumplirá con los SLAs establecidos una vez desplegado en producción.


// === ARCHIVO: modules/network/variables.tf ===
variable "environment" {
  description = "Entorno de despliegue (dev, qa, prod)"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "location_short" {
  description = "Código corto de ubicación (ej. eus, eus2)"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "vnet_address_space" {
  description = "Espacio de direcciones de la VNet"
  type        = list(string)
}

variable "public_subnet_prefixes" {
  description = "Prefijos CIDR para subred pública"
  type        = list(string)
}

variable "private_subnet_prefixes" {
  description = "Prefijos CIDR para subred privada"
  type        = list(string)
}

variable "database_subnet_prefixes" {
  description = "Prefijos CIDR para subred de base de datos"
  type        = list(string)
}

variable "app_gateway_subnet_prefixes" {
  description = "Prefijos CIDR para subred de Application Gateway"
  type        = list(string)
}

variable "dns_servers" {
  description = "Servidores DNS personalizados"
  type        = list(string)
  default     = []
}

variable "dns_zone_name" {
  description = "Nombre de la zona DNS privada"
  type        = string
  default     = "private.azure.com"
}

variable "on_premises_address_space" {
  description = "Espacio de direcciones on-premises para rutas"
  type        = string
  default     = "0.0.0.0/0"
}

variable "cost_center" {
  description = "Centro de costos para etiquetado"
  type        = string
  default     = "IT-Infrastructure"
}

variable "common_tags" {
  description = "Mapa de etiquetas comunes"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/network/outputs.tf ===
output "virtual_network_id" {
  description = "ID de la red virtual"
  value       = azurerm_virtual_network.main_vnet.id
}

output "virtual_network_name" {
  description = "Nombre de la red virtual"
  value       = azurerm_virtual_network.main_vnet.name
}

output "subnet_public_id" {
  description = "ID de la subred pública"
  value       = azurerm_subnet.subnet_public.id
}

output "subnet_private_id" {
  description = "ID de la subred privada"
  value       = azurerm_subnet.subnet_private.id
}

output "subnet_database_id" {
  description = "ID de la subred de base de datos"
  value       = azurerm_subnet.subnet_database.id
}

output "nsg_public_id" {
  description = "ID del NSG público"
  value       = azurerm_network_security_group.nsg_public.id
}

output "nsg_private_id" {
  description = "ID del NSG privado"
  value       = azurerm_network_security_group.nsg_private.id
}

output "private_dns_zone_id" {
  description = "ID de la zona DNS privada"
  value       = azurerm_private_dns_zone.private_dns.id
}

// === ARCHIVO: modules/security/variables.tf ===
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "tenant_id" {
  description = "ID del tenant de Azure AD"
  type        = string
}

variable "notification_api_key" {
  description = "API key para el servicio de notificaciones"
  type        = string
  sensitive   = true
}

variable "notification_connection_string" {
  description = "Cadena de conexión para notificaciones"
  type        = string
  sensitive   = true
}

variable "functions_managed_identity_principal_id" {
  description = "ID principal de la identidad gestionada de Functions"
  type        = string
}

variable "api_key_expiration" {
  description = "Fecha de expiración de la API key"
  type        = string
  default     = null
}

variable "connection_string_expiration" {
  description = "Fecha de expiración de la cadena de conexión"
  type        = string
  default     = null
}

variable "storage_replication_type" {
  description = "Tipo de replicación del storage account"
  type        = string
  default     = "LRS"
}

variable "storage_encryption_key_name" {
  description = "Nombre de la clave de cifrado en Key Vault"
  type        = string
  default     = ""
}

variable "storage_encryption_key_version" {
  description = "Versión de la clave de cifrado"
  type        = string
  default     = ""
}

variable "allowed_ip_ranges" {
  description = "Rangos IP permitidos"
  type        = list(string)
  default     = []
}

variable "allowed_subnet_ids" {
  description = "IDs de subredes permitidas"
  type        = list(string)
  default     = []
}

variable "log_analytics_workspace_id" {
  description = "ID del workspace de Log Analytics"
  type        = string
  default     = ""
}

variable "common_tags" {
  description = "Mapa de etiquetas comunes"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/security/outputs.tf ===
output "key_vault_id" {
  description = "ID del Key Vault"
  value       = azurerm_key_vault.notifications_vault.id
}

output "key_vault_name" {
  description = "Nombre del Key Vault"
  value       = azurerm_key_vault.notifications_vault.name
}

output "key_vault_uri" {
  description = "URI del Key Vault"
  value       = azurerm_key_vault.notifications_vault.vault_uri
}

output "storage_account_id" {
  description = "ID de la cuenta de almacenamiento"
  value       = azurerm_storage_account.notification_storage.id
}

output "storage_account_name" {
  description = "Nombre de la cuenta de almacenamiento"
  value       = azurerm_storage_account.notification_storage.name
}

// === ARCHIVO: modules/monitoring/variables.tf ===
variable "environment" {
  description = "Entorno de despliegue"
  type        = string
}

variable "location" {
  description = "Región de Azure"
  type        = string
}

variable "resource_group_name" {
  description = "Nombre del grupo de recursos"
  type        = string
}

variable "functions_resource_ids" {
  description = "IDs de recursos de Functions para alertas"
  type        = list(string)
  default     = []
}

variable "service_bus_resource_ids" {
  description = "IDs de recursos de Service Bus para alertas"
  type        = list(string)
  default     = []
}

variable "functions_target_resource_id" {
  description = "ID del recurso de Functions para autoescalado"
  type        = string
  default     = ""
}

variable "log_analytics_sku" {
  description = "SKU de Log Analytics"
  type        = string
  default     = "PerGB2018"
}

variable "log_retention_days" {
  description = "Días de retención de logs"
  type        = number
  default     = 30
}

variable "log_analytics_quota_gb" {
  description = "Cuota diaria de Log Analytics en GB"
  type        = number
  default     = 10
}

variable "alert_role_id" {
  description = "ID del rol para alertas de Azure"
  type        = string
  default     = "acdd72a7-3385-48ef-bd42-f606fba81ae7"
}

variable "security_team_email" {
  description = "Email del equipo de seguridad"
  type        = string
  default     = ""
}

variable "ops_team_email" {
  description = "Email del equipo de operaciones"
  type        = string
  default     = ""
}

variable "pagerduty_webhook_url" {
  description = "URL de webhook de PagerDuty"
  type        = string
  default     = ""
}

variable "execution_time_threshold" {
  description = "Umbral de tiempo de ejecución para alertas (ms)"
  type        = number
  default     = 5000
}

variable "failed_requests_threshold" {
  description = "Umbral de solicitudes fallidas para alertas"
  type        = number
  default     = 10
}

variable "http_errors_threshold" {
  description = "Umbral de errores HTTP para alertas"
  type        = number
  default     = 5
}

variable "queue_depth_threshold" {
  description = "Umbral de profundidad de cola para alertas"
  type        = number
  default     = 1000
}

variable "autoscale_min_instances" {
  description = "Mínimo de instancias para autoescalado"
  type        = number
  default     = 1
}

variable "autoscale_max_instances" {
  description = "Máximo de instancias para autoescalado"
  type        = number
  default     = 10
}

variable "autoscale_default_instances" {
  description = "Instancias por defecto para autoescalado"
  type        = number
  default     = 2
}

variable "autoscale_scale_out_threshold" {
  description = "Umbral para escalar horizontalmente"
  type        = number
  default     = 200
}

variable "autoscale_scale_out_increment" {
  description = "Incremento al escalar horizontalmente"
  type        = number
  default     = 1
}

variable "autoscale_scale_in_threshold" {
  description = "Umbral para reducir instancias"
  type        = number
  default     = 50
}

variable "autoscale_scale_in_decrement" {
  description = "Decremento al reducir instancias"
  type        = number
  default     = 1
}

variable "common_tags" {
  description = "Mapa de etiquetas comunes"
  type        = map(string)
  default     = {}
}

// === ARCHIVO: modules/monitoring/outputs.tf ===
output "log_analytics_workspace_id" {
  description = "ID del workspace de Log Analytics"
  value       = azurerm_log_analytics_workspace.notifications_workspace.id
}

output "log_analytics_workspace_name" {
  description = "Nombre del workspace de Log Analytics"
  value       = azurerm_log_analytics_workspace.notifications_workspace.name
}

output "action_group_critical_id" {
  description = "ID del grupo de alertas críticas"
  value       = azurerm_monitor_action_group.notifications_critical_alerts.id
}

output "action_group_warning_id" {
  description = "ID del grupo de alertas de advertencia"
  value       = azurerm_monitor_action_group.notifications_warning_alerts.id
}

output "autoscale_setting_id" {
  description = "ID de la configuración de autoescalado"
  value       = azurerm_monitor_autoscale_setting.functions_autoscale.id
}

```
