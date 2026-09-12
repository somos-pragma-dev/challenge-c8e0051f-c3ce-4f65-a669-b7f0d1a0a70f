terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_resource_group" "monitoring_rg" {
  name     = var.resource_group_name
  location = var.location

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "monitoring"
    Purpose     = "Log Analytics y alertas de observabilidad"
  })
}

resource "azurerm_log_analytics_workspace" "notifications_workspace" {
  name                = "log-notifications-${var.environment}"
  location            = azurerm_resource_group.monitoring_rg.location
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  sku                 = var.log_analytics_sku
  retention_in_days   = var.log_retention_days

  daily_quota_gb = var.log_analytics_quota_gb

  solution_namespaces {
    workspace_name = "log-notifications-${var.environment}"
    workspace_key  = "log-notifications-${var.environment}"
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Module      = "monitoring"
  })
}

resource "azurerm_log_analytics_solution" "containers_solution" {
  solution_name         = "ContainerInsights-${var.environment}"
  location              = azurerm_resource_group.monitoring_rg.location
  resource_group_name   = azurerm_resource_group.monitoring_rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.notifications_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.notifications_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/Containers"
  }

  tags = var.common_tags
}

resource "azurerm_log_analytics_solution" "vm_insights_solution" {
  solution_name         = "VMInsights-${var.environment}"
  location              = azurerm_resource_group.monitoring_rg.location
  resource_group_name   = azurerm_resource_group.monitoring_rg.name
  workspace_resource_id = azurerm_log_analytics_workspace.notifications_workspace.id
  workspace_name        = azurerm_log_analytics_workspace.notifications_workspace.name

  plan {
    publisher = "Microsoft"
    product   = "OMSGallery/VMInsights"
  }

  tags = var.common_tags
}

resource "azurerm_monitor_action_group" "notifications_critical_alerts" {
  name                = "ag-notifications-critical-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  short_name          = "NotifCrit"

  arm_role_alert {
    role_id = var.alert_role_id
    name    = "Security Reader"
  }

  email_receiver {
    name          = "security-team"
    email_address = var.security_team_email
    use_common_alert_schema = true
  }

  email_receiver {
    name          = "ops-team"
    email_address = var.ops_team_email
    use_common_alert_schema = true
  }

  webhook_receiver {
    name        = "pagerduty"
    service_uri = var.pagerduty_webhook_url
    use_common_alert_schema = true
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertType   = "Critical"
  })
}

resource "azurerm_monitor_action_group" "notifications_warning_alerts" {
  name                = "ag-notifications-warning-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  short_name          = "NotifWarn"

  email_receiver {
    name          = "ops-team"
    email_address = var.ops_team_email
    use_common_alert_schema = true
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertType   = "Warning"
  })
}

resource "azurerm_monitor_metric_alert" "functions_execution_time" {
  name                = "metric-functions-execution-time-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando el tiempo de ejecución de Functions excede el umbral"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  scope {
    ids = var.functions_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "FunctionExecutionTime"
    aggregation      = "Average"
    operator         = "GreaterThan"
    threshold        = var.execution_time_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_critical_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "ExecutionTime"
  })
}

resource "azurerm_monitor_metric_alert" "functions_failed_requests" {
  name                = "metric-functions-failed-requests-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando hay solicitudes fallidas en Functions"
  severity            = 1
  frequency           = "PT5M"
  window_size         = "PT10M"

  scope {
    ids = var.functions_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "FunctionExecutionCount"
    aggregation      = "Sum"
    operator         = "GreaterThan"
    threshold        = var.failed_requests_threshold

    dimension {
      name     = "Result"
      operator = "Include"
      values   = ["Failure"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_critical_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "FailedRequests"
  })
}

resource "azurerm_monitor_metric_alert" "app_service_http_errors" {
  name                = "metric-app-http-errors-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando el porcentaje de errores HTTP excede el umbral"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  scope {
    ids = var.functions_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.Web/sites"
    metric_name      = "Http5xx"
    aggregation      = "Sum"
    operator         = "GreaterThan"
    threshold        = var.http_errors_threshold
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_warning_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "HttpErrors"
  })
}

resource "azurerm_monitor_metric_alert" "service_bus_queue_depth" {
  name                = "metric-servicebus-queue-depth-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  description         = "Alerta cuando la cola de Service Bus tiene mensajes pendientes excesivos"
  severity            = 2
  frequency           = "PT5M"
  window_size         = "PT15M"

  scope {
    ids = var.service_bus_resource_ids
  }

  criteria {
    metric_namespace = "Microsoft.ServiceBus/namespaces"
    metric_name      = "ActiveMessages"
    aggregation      = "Maximum"
    operator         = "GreaterThan"
    threshold        = var.queue_depth_threshold

    dimension {
      name     = "EntityName"
      operator = "Include"
      values   = ["*"]
    }
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_warning_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertMetric = "QueueDepth"
  })
}

resource "azurerm_monitor_scheduled_query_rules_alert" "functions_exception_rate" {
  name                = "query-functions-exception-rate-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  location            = azurerm_resource_group.monitoring_rg.location
  description         = "Alerta cuando la tasa de excepciones en Functions excede el 5%"
  severity            = 1
  frequency           = "PT10M"
  window_size         = "PT30M"

  data_source_id = azurerm_log_analytics_workspace.notifications_workspace.id

  query = <<-QUERY
    let threshold = 5;
    let operationName = "Notifications";
    AppExceptions
    | where TimeGenerated > ago(30m)
    | where OperationName contains operationName
    | summarize ExceptionCount = count(), TotalRequests = dcount(OperationId) by bin(TimeGenerated, 10m)
    | where (ExceptionCount * 100.0 / TotalRequests) > threshold
  QUERY

  criteria {
    operator           = "GreaterThan"
    threshold          = 0
    time_aggregation   = "Count"
    resource_id_column = "_ResourceId"
  }

  action {
    action_group_id = azurerm_monitor_action_group.notifications_critical_alerts.id
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    AlertType   = "LogQuery"
  })
}

resource "azurerm_monitor_autoscale_setting" "functions_autoscale" {
  name                = "autoscale-functions-${var.environment}"
  resource_group_name = azurerm_resource_group.monitoring_rg.name
  location            = azurerm_resource_group.monitoring_rg.location
  target_resource_id  = var.functions_target_resource_id

  profile {
    name = "default"

    capacity {
      minimum = var.autoscale_min_instances
      maximum = var.autoscale_max_instances
      default = var.autoscale_default_instances
    }

    rule {
      metric_trigger {
        metric_name        = "FunctionExecutionCount"
        metric_resource_id = var.functions_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Sum"
        time_window        = "PT10M"
        time_aggregation   = "Total"
        operator           = "GreaterThan"
        threshold          = var.autoscale_scale_out_threshold
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = var.autoscale_scale_out_increment
      }
    }

    rule {
      metric_trigger {
        metric_name        = "FunctionExecutionCount"
        metric_resource_id = var.functions_target_resource_id
        time_grain         = "PT1M"
        statistic          = "Sum"
        time_window        = "PT30M"
        time_aggregation   = "Total"
        operator           = "LessThan"
        threshold          = var.autoscale_scale_in_threshold
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = var.autoscale_scale_in_decrement
      }
    }
  }

  notification {
    email {
      send_to_subscription_administrator    = true
      send_to_subscription_co_administrator = true
      custom_emails                         = [var.ops_team_email]
    }
  }

  tags = merge(var.common_tags, {
    Environment = var.environment
    Feature     = "Autoscale"
  })
}