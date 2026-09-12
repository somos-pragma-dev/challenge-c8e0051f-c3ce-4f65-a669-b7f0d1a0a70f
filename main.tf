terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

provider "azurerm" {
  features {}
  skip_provider_registration = false
  use_msi                     = var.use_msi
  subscription_id             = var.subscription_id
  tenant_id                   = var.tenant_id
}

locals {
  common_tags = {
    Environment = var.environment
    Project     = "notification-service"
    ManagedBy   = "Terraform"
    Owner       = "cloudops-team@empresa.com"
    CostCenter  = "IT-Infrastructure"
    Compliance  = "SOC2"
  }

  service_bus_config = {
    sku           = var.service_bus_sku
    capacity      = var.service_bus_capacity
    zone_redundant = var.enable_availability_zones
  }

  function_app_config = {
    os_type           = "Linux"
    runtime           = "node"
    runtime_version   = "~18"
    consumption_plan  = var.use_consumption_plan
    always_on         = var.enable_always_on
  }
}

resource "azurerm_resource_group" "notification_rg" {
  name     = "rg-notifications-${var.environment}"
  location = var.location

  tags = merge(local.common_tags, {
    Description = "Resource group para el servicio de notificaciones"
    Tier        = "Production"
  })
}

resource "azurerm_servicebus_namespace" "notifications_ns" {
  name                = "sb-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  sku                 = local.service_bus_config.sku
  capacity            = local.service_bus_config.capacity
  zone_redundant      = local.service_bus_config.zone_redundant

  tags = merge(local.common_tags, {
    Name        = "Service Bus Namespace - Notificaciones"
    Component   = "Messaging"
    Criticality = "High"
  })
}

resource "azurerm_servicebus_queue" "email_queue" {
  name                = "email-notifications"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  max_delivery_count  = 10
  lock_duration       = "PT1M"
  max_size_in_megabytes = 1024
  enable_partitioning = true

  dead_letter_on_expiration_enabled = true
  max_message_size_in_kilobytes     = 256

  tags = merge(local.common_tags, {
    Purpose = "Cola para notificaciones por correo electrónico"
    Type    = "Async"
  })
}

resource "azurerm_servicebus_queue" "sms_queue" {
  name                = "sms-notifications"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  max_delivery_count  = 10
  lock_duration       = "PT1M"
  max_size_in_megabytes = 1024
  enable_partitioning = true

  dead_letter_on_expiration_enabled = true

  tags = merge(local.common_tags, {
    Purpose = "Cola para notificaciones por SMS"
    Type    = "Async"
  })
}

resource "azurerm_servicebus_queue" "push_queue" {
  name                = "push-notifications"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  max_delivery_count  = 10
  lock_duration       = "PT1M"
  max_size_in_megabytes = 1024
  enable_partitioning = true

  dead_letter_on_expiration_enabled = true

  tags = merge(local.common_tags, {
    Purpose = "Cola para notificaciones push"
    Type    = "Async"
  })
}

resource "azurerm_servicebus_topic" "notifications_topic" {
  name                = "notifications-all"
  namespace_id        = azurerm_servicebus_namespace.notifications_ns.id
  enable_partitioning = true

  tags = merge(local.common_tags, {
    Purpose = "Tópico para distribución de notificaciones"
  })
}

resource "azurerm_servicebus_subscription" "email_subscription" {
  name                = "email-processor-sub"
  topic_id            = azurerm_servicebus_topic.notifications_topic.id
  max_delivery_count  = 10
  lock_duration       = "PT5M"
  dead_letter_on_message_expiration_enabled = true

  filter_type = "SqlFilter"
  sql_filter  = "notificationType = 'email'"

  tags = merge(local.common_tags, {
    Purpose = "Suscripción para procesamiento de emails"
  })
}

resource "azurerm_servicebus_subscription" "sms_subscription" {
  name                = "sms-processor-sub"
  topic_id            = azurerm_servicebus_topic.notifications_topic.id
  max_delivery_count  = 10
  lock_duration       = "PT5M"
  dead_letter_on_message_expiration_enabled = true

  filter_type = "SqlFilter"
  sql_filter  = "notificationType = 'sms'"

  tags = merge(local.common_tags, {
    Purpose = "Suscripción para procesamiento de SMS"
  })
}

resource "azurerm_servicebus_subscription" "push_subscription" {
  name                = "push-processor-sub"
  topic_id            = azurerm_servicebus_topic.notifications_topic.id
  max_delivery_count  = 10
  lock_duration       = "PT5M"
  dead_letter_on_message_expiration_enabled = true

  filter_type = "SqlFilter"
  sql_filter  = "notificationType = 'push'"

  tags = merge(local.common_tags, {
    Purpose = "Suscripción para procesamiento de push notifications"
  })
}

resource "azurerm_notification_hub_namespace" "notification_hub_ns" {
  name                = "nh-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  namespace_type      = "NotificationHub"
  sku_name            = var.notification_hub_sku

  tags = merge(local.common_tags, {
    Purpose = "Namespace para Notification Hubs"
  })
}

resource "azurerm_notification_hub" "push_hub" {
  name                = "nh-push-${var.environment}"
  namespace_name      = azurerm_notification_hub_namespace.notification_hub_ns.name
  resource_group_name = azurerm_resource_group.notification_rg.location
  location            = azurerm_resource_group.notification_rg.location

  tags = merge(local.common_tags, {
    Purpose = "Hub para notificaciones push"
    Platform = "APNS,FCM"
  })
}

resource "azurerm_storage_account" "function_storage" {
  name                     = "stfn${var.environment}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.notification_rg.name
  location                 = azurerm_resource_group.notification_rg.location
  account_tier             = var.storage_account_tier
  account_replication_type = var.storage_replication_type
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"

  blob_properties {
    versioning_enabled = true
    delete_retention_days = 7
  }

  network_rules {
    default_action             = "Allow"
    bypass                     = ["AzureServices"]
    ip_rules                   = var.allowed_ip_ranges
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = merge(local.common_tags, {
    Purpose = "Storage account para Azure Functions"
    Type    = "Storage"
  })
}

resource "azurerm_app_service_plan" "function_app_plan" {
  name                = "asp-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  kind                = local.function_app_config.os_type

  sku {
    tier = var.app_service_plan_tier
    size = var.app_service_plan_size
  }

  reserved = local.function_app_config.os_type == "Linux"

  tags = merge(local.common_tags, {
    Purpose = "App Service Plan para Functions"
  })
}

resource "azurerm_linux_function_app" "notification_functions" {
  name                = "func-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  service_plan_id     = azurerm_app_service_plan.function_app_plan.id
  storage_account_name = azurerm_storage_account.function_storage.name
  storage_account_access_key = azurerm_storage_account.function_storage.primary_access_key

  https_only = true
  enabled    = true

  site_config {
    always_on                = local.function_app_config.always_on
    linux_fx_version         = "${local.function_app_config.runtime}|${local.function_app_config.runtime_version}"
    min_tls_version          = "1.2"
    ftps_state               = "Disabled"

    cors {
      allowed_origins = var.allowed_origins
      support_credentials = false
    }

    application_stack {
      node_version = local.function_app_config.runtime_version
    }

    health_check_path = "/api/health"
  }

  app_settings = {
    "WEBSITE_RUN_FROM_PACKAGE"           = "1"
    "FUNCTIONS_WORKER_RUNTIME"           = "node"
    "ServiceBusConnection__fullyQualifiedNamespace" = "${azurerm_servicebus_namespace.notifications_ns.name}.servicebus.windows.net"
    "NotificationHubConnection"          = azurerm_notification_hub.push_hub.default_notification_hub_connection_string
    "AZURE_STORAGE_CONNECTION_STRING"    = azurerm_storage_account.function_storage.primary_connection_string
    "ENVIRONMENT"                        = var.environment
    "LOG_LEVEL"                          = var.log_level
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(local.common_tags, {
    Purpose = "Azure Functions para procesamiento de notificaciones"
    Function = "NotificationProcessor"
  })
}

resource "azurerm_key_vault" "notification_kv" {
  name                = "kv-notifications-${var.environment}"
  location            = azurerm_resource_group.notification_rg.location
  resource_group_name = azurerm_resource_group.notification_rg.name
  tenant_id           = var.tenant_id
  sku_name            = "standard"

  soft_delete_retention_days = 90
  purge_protection_enabled   = var.enable_purge_protection

  network_acls {
    default_action = "Allow"
    bypass         = "AzureServices"
  }

  tags = merge(local.common_tags, {
    Purpose = "Key Vault para secretos del servicio de notificaciones"
    Tier    = "Sensitive"
  })
}

resource "azurerm_key_vault_secret" "servicebus_connection_string" {
  name         = "servicebus-connection-string"
  key_vault_id = azurerm_key_vault.notification_kv.id
  value        = azurerm_servicebus_namespace.notifications_ns.default_primary_connection_string

  expiration_date = var.secrets_expiration_date

  tags = merge(local.common_tags, {
    Purpose = "Connection string para Service Bus"
    Type    = "Secret"
  })
}

resource "azurerm_key_vault_secret" "notification_hub_connection" {
  name         = "notification-hub-connection"
  key_vault_id = azurerm_key_vault.notification_kv.id
  value        = azurerm_notification_hub.push_hub.default_notification_hub_connection_string

  expiration_date = var.secrets_expiration_date

  tags = merge(local.common_tags, {
    Purpose = "Connection string para Notification Hub"
    Type    = "Secret"
  })
}

resource "azurerm_role_assignment" "function_to_servicebus" {
  scope                = azurerm_servicebus_namespace.notifications_ns.id
  role_definition_name = "Azure Service Bus Data Owner"
  principal_id         = azurerm_linux_function_app.notification_functions.identity.0.principal_id
}

resource "azurerm_role_assignment" "function_to_keyvault" {
  scope                = azurerm_key_vault.notification_kv.id
  role_definition_name = "Key Vault Secrets User"
  principal_id         = azurerm_linux_function_app.notification_functions.identity.0.principal_id
}

resource "azurerm_role_assignment" "function_to_storage" {
  scope                = azurerm_storage_account.function_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_linux_function_app.notification_functions.identity.0.principal_id
}

resource "random_string" "storage_suffix" {
  length  = 5
  special = false
  upper   = false
  numeric = true
}

module "network" {
  source = "./modules/network"

  environment          = var.environment
  location             = var.location
  resource_group_name  = azurerm_resource_group.notification_rg.name
  vnet_address_space   = var.vnet_address_space
  subnet_prefixes      = var.subnet_prefixes
  enable_private_endpoints = var.enable_private_endpoints
  common_tags          = local.common_tags
}

module "security" {
  source = "./modules/security"

  environment              = var.environment
  location                 = var.location
  resource_group_name      = azurerm_resource_group.notification_rg.name
  key_vault_id             = azurerm_key_vault.notification_kv.id
  function_app_id          = azurerm_linux_function_app.notification_functions.id
  servicebus_namespace_id = azurerm_servicebus_namespace.notifications_ns.id
  enable_advanced_threat_protection = var.enable_advanced_threat_protection
  common_tags              = local.common_tags
}

module "monitoring" {
  source = "./modules/monitoring"

  environment             = var.environment
  location                = var.location
  resource_group_name     = azurerm_resource_group.notification_rg.name
  function_app_id         = azurerm_linux_function_app.notification_functions.id
  servicebus_namespace_id = azurerm_servicebus_namespace.notifications_ns.id
  notification_hub_id     = azurerm_notification_hub.push_hub.id
  log_analytics_workspace_id = var.log_analytics_workspace_id
  common_tags             = local.common_tags
}