terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_resource_group" "notifications_rg" {
  name     = "rg-notifications-${var.environment}"
  location = var.location

  tags = merge(
    var.common_tags,
    {
      environment  = var.environment
      component    = "notifications"
      cost_center  = var.cost_center
      data_classification = "internal"
    }
  )
}

resource "azurerm_storage_account" "notifications_storage" {
  name                     = "stnotif${var.environment}001"
  resource_group_name      = azurerm_resource_group.notifications_rg.name
  location                 = azurerm_resource_group.notifications_rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
  enable_https_traffic_only = true
  min_tls_version          = "TLS1_2"

  blob_properties {
    delete_retention_policy {
      days = 7
    }
  }

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_app_service_plan" "notifications_asp" {
  name                = "asp-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  kind                = "FunctionApp"

  sku {
    tier = "Standard"
    size = "S1"
  }

  maximum_elastic_worker_count = 20

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_function_app" "notifications_func" {
  name                = "func-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  app_service_plan_id = azurerm_app_service_plan.notifications_asp.id
  storage_account_name = azurerm_storage_account.notifications_storage.name
  storage_account_access_key = azurerm_storage_account.notifications_storage.primary_access_key
  https_only          = true
  os_type             = "Linux"
  runtime_stack       = "PYTHON|3.11"
  version             = "~4"

  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME"       = "python"
    "AzureWebJobsFeatureFlags"       = "EnableWorkerIndexing"
    "APPINSIGHTS_INSTRUMENTATIONKEY" = var.app_insights_instrumentation_key
    "NOTIFICATION_HUB_CONNECTION"    = azurerm_notification_hub_namespace.notifications_ns.connection_string
    "EMAIL_SERVICE_ENDPOINT"         = var.email_service_endpoint
    "SMS_PROVIDER_ENDPOINT"          = var.sms_provider_endpoint
    "ENVIRONMENT"                    = var.environment
    "LOG_LEVEL"                      = var.log_level
  }

  identity {
    type = "SystemAssigned"
  }

  site_config {
    always_on                = true
    ftps_state               = "Disabled"
    http2_enabled            = true
    min_tls_version          = "1.2"
    pre_warm_instance_count  = 1

    application_stack {
      python_version = "3.11"
    }

    cors {
      allowed_origins = var.allowed_origins
      support_credentials = true
    }
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "notifications"
    }
  )
}

resource "azurerm_notification_hub_namespace" "notifications_ns" {
  name                = "nhns-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  namespace_type      = "NotificationHub"
  sku_name            = "Standard"

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_notification_hub" "notifications_hub" {
  name                = "nh-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  namespace_name      = azurerm_notification_hub_namespace.notifications_ns.name

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_monitor_autoscale_setting" "notifications_autoscale" {
  name                = "autoscale-notifications-${var.environment}"
  location            = azurerm_resource_group.notifications_rg.location
  resource_group_name = azurerm_resource_group.notifications_rg.name
  target_resource_id  = azurerm_function_app.notifications_func.id

  profile {
    name = "default"

    capacity {
      minimum = var.autoscale_min_instances
      maximum = var.autoscale_max_instances
      default = var.autoscale_default_instances
    }

    rule {
      metric_trigger {
        metric_name        = "Requests"
        metric_resource_id = azurerm_function_app.notifications_func.id
        time_grain         = "PT1M"
        statistic          = "Sum"
        time_window        = "PT5M"
        time_aggregation   = "Total"
        operator           = "GreaterThan"
        threshold          = var.autoscale_request_threshold
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT5M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Requests"
        metric_resource_id = azurerm_function_app.notifications_func.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT10M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = var.autoscale_scale_down_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT10M"
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator = true
      send_to_subscription_co_administrator = true
      custom_emails = var.notification_emails
    }
  }

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_role_assignment" "notifications_func_keyvault_reader" {
  scope                = var.key_vault_id
  role_definition_name = "Key Vault Reader"
  principal_id         = azurerm_function_app.notifications_func.identity.0.principal_id
}

resource "azurerm_role_assignment" "notifications_func_storage_contributor" {
  scope                = azurerm_storage_account.notifications_storage.id
  role_definition_name = "Storage Blob Data Contributor"
  principal_id         = azurerm_function_app.notifications_func.identity.0.principal_id
}