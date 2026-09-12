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