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