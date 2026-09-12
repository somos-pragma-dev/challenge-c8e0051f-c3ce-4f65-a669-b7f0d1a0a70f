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