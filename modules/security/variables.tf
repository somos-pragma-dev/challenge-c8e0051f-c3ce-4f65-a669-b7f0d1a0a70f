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