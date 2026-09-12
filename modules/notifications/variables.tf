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