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