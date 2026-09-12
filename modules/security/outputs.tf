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