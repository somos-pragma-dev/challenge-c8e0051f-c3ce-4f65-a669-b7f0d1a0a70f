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