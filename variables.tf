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