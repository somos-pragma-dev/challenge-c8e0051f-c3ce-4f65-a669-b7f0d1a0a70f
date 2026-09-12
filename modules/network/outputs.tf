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