terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_resource_group" "security_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "security"
    Purpose     = "Key Vault y políticas de seguridad"
  })
}

resource "azurerm_key_vault" "notifications_vault" {
  name                = "kv-notifications-${var.environment}"
  location            = azurerm_resource_group.security_rg.location
  resource_group_name = azurerm_resource_group.security_rg.name
  tenant_id           = var.tenant_id

  sku_name = "standard"

  enable_rbac_authorization       = true
  enable_purge_protection         = var.environment != "dev"
  soft_delete_retention_days      = 90
  enable_soft_delete              = true
  bypass                          = "AzureServices"
  default_action                  = "Allow"
  enable_vm_access                = false
  enable_for_disk_encryption      = true
  enable_for_template_deployment  = true

  network_acls {
    bypass                     = "AzureServices"
    default_action             = "Allow"
    ip_rules                   = []
    virtual_network_subnet_ids = var.allowed_subnet_ids
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "security"
  })
}

resource "azurerm_key_vault_secret" "notification_api_key" {
  name         = "notification-api-key"
  value        = var.notification_api_key
  key_vault_id = azurerm_key_vault.notifications_vault.id

  expiration_date = var.api_key_expiration

  tags = merge(var.common_tags, {
    Environment = var.environment
    SecretType  = "APIKey"
  })
}

resource "azurerm_key_vault_secret" "notification_connection_string" {
  name         = "notification-connection-string"
  value        = var.notification_connection_string
  key_vault_id = azurerm_key_vault.notifications_vault.id

  expiration_date = var.connection_string_expiration

  tags = merge(var.common_tags, {
    Environment = var.environment
    SecretType  = "ConnectionString"
  })
}

resource "azurerm_key_vault_access_policy" "functions_app_policy" {
  key_vault_id = azurerm_key_vault.notifications_vault.id
  tenant_id    = var.tenant_id
  object_id    = var.functions_managed_identity_principal_id

  key_permissions = ["Get", "List"]

  secret_permissions = ["Get", "List"]

  certificate_permissions = ["Get", "List"]

  storage_permissions = []
}

resource "azurerm_role_assignment" "key_vault_reader" {
  scope                = azurerm_key_vault.notifications_vault.id
  role_definition_name = "Key Vault Reader"
  principal_id         = var.functions_managed_identity_principal_id
}

resource "azurerm_storage_account" "notification_storage" {
  name                     = "stnotif${var.environment}${random_string.storage_suffix.result}"
  resource_group_name      = azurerm_resource_group.security_rg.name
  location                 = azurerm_resource_group.security_rg.location
  account_tier             = "Standard"
  account_replication_type = var.storage_replication_type
  account_kind             = "StorageV2"

  enable_https_traffic_only = true
  min_tls_version           = "TLS1_2"

  blob_properties {
    versioning_enabled = true
    delete_retention_days = 7

    cors_rule {
      allowed_headers    = ["*"]
      allowed_methods    = ["GET", "POST", "PUT"]
      allowed_origins    = ["*"]
      exposed_headers    = ["*"]
      max_age_in_seconds = 3600
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "security"
    Purpose     = "Almacenamiento cifrado para notificaciones"
  })
}

resource "azurerm_storage_account_customer_managed_key" "storage_cmk" {
  storage_account_id = azurerm_storage_account.notification_storage.id
  key_vault_id       = azurerm_key_vault.notifications_vault.id
  key_name           = var.storage_encryption_key_name
  key_version        = var.storage_encryption_key_version
}

resource "azurerm_storage_account_network_rules" "storage_network_rules" {
  storage_account_id = azurerm_storage_account.notification_storage.id

  bypass         = ["AzureServices"]
  default_action = "Allow"

  ip_rules                   = var.allowed_ip_ranges
  virtual_network_subnet_ids = var.allowed_subnet_ids
}

resource "random_string" "storage_suffix" {
  length  = 5
  lower   = true
  numeric = true
  special = false
}

resource "azurerm_monitor_diagnostic_setting" "key_vault_diagnostics" {
  name                           = "kv-diags-${var.environment}"
  target_resource_id             = azurerm_key_vault.notifications_vault.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category = "AuditEvent"

    retention_policy {
      enabled = true
      days    = 365
    }
  }

  enabled_log {
    category = "SecurityEvent"

    retention_policy {
      enabled = true
      days    = 90
    }
  }

  metric {
    category = "AllMetrics"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}

resource "azurerm_monitor_diagnostic_setting" "storage_diagnostics" {
  name                           = "st-diags-${var.environment}"
  target_resource_id             = azurerm_storage_account.notification_storage.id
  log_analytics_workspace_id     = var.log_analytics_workspace_id
  log_analytics_destination_type = "Dedicated"

  enabled_log {
    category = "StorageRead"

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  enabled_log {
    category = "StorageWrite"

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  enabled_log {
    category = "StorageDelete"

    retention_policy {
      enabled = true
      days    = 30
    }
  }

  metric {
    category = "Transaction"

    retention_policy {
      enabled = true
      days    = 30
    }
  }
}