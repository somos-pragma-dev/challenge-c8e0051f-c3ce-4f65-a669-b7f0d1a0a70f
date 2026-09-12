# ==============================================================================
# Valores específicos para el ambiente de QA
# Servicio de Notificaciones en Azure
# ==============================================================================

# Configuración general del ambiente
environment                = "qa"
location                   = "eastus2"
project_name               = "notificaciones"

# Grupo de recursos
resource_group_name         = "rg-notificaciones-qa"
resource_group_location    = "eastus2"

# Configuración de red
vnet_cidr                  = "10.1.0.0/16"
subnet_functions_cidr      = "10.1.1.0/24"
subnet_private_endpoints   = "10.1.2.0/24"
dns_zone_name              = "notificaciones.internal"

# Configuración de Azure Functions
function_app_name          = "func-notificaciones-qa"
function_app_sku           = "Dynamic"
function_app_capacity      = 0
function_app_os_type       = "Linux"
function_app_runtime       = "python"
function_app_runtime_version = "4"
app_service_plan_name      = "asp-notificaciones-qa"
always_on                  = false

# Configuración de Storage Account para colas de notificaciones
storage_account_name       = "stonotificacionesqa"
storage_account_tier       = "Standard"
storage_account_replication = "LRS"
storage_account_kind       = "StorageV2"
queue_name                 = "notificaciones-queue"

# Configuración de Azure Key Vault para secretos
key_vault_name             = "kv-notificaciones-qa"
key_vault_sku              = "standard"
enable_soft_delete         = true
soft_delete_retention_days = 14

# Configuración de seguridad
enable_private_endpoint    = true
enable_vnet_integration    = true
allowed_ingress_ips        = ["10.1.0.0/16"]
enable_role_assignment     = true

# Configuración de alta disponibilidad y redundancia
high_availability_enabled  = true
geo_redundant_enabled      = false
backup_enabled             = true

# Configuración de monitoreo y logging
log_analytics_workspace_name = "law-notificaciones-qa"
log_analytics_retention_days = 30
enable_app_insights        = true
app_insights_name          = "appi-notificaciones-qa"

# Configuración de alertas
alert_email_recipients     = ["qa-team@empresa.com", "notificaciones-qa@empresa.com", "cloudops@empresa.com"]
alert_severity_threshold   = "warning"
enable_health_check        = true
health_check_interval      = 30

# Configuración de escalabilidad
auto_scale_enabled         = true
min_instances              = 2
max_instances              = 5
scale_threshold_cpu        = 60
scale_threshold_requests   = 800

# Configuración de cifrado
encryption_at_rest_enabled = true
tls_version                = "1.2"

# Configuración de etiquetas (tags) para costos y gobierno
tags = {
  Environment     = "QA"
  Owner           = "CloudOps Team"
  CostCenter      = "IT-QualityAssurance"
  Project         = "Notificaciones"
  ManagedBy       = "Terraform"
  Compliance      = "Internal"
  DataSensitivity = "Medium"
  BackupRequired  = "true"
  DRTier          = "QA"
}

# Configuración de red avanzada
enable_network_isolation   = true
use_private_dns            = true
dns_forwarder_enabled      = true

# Configuración de políticas de acceso
api_key_required           = true
api_key_rotation_days      = 60
enable_mtls                = false

# Configuración de retención de logs
diagnostic_retention_days  = 30
log_retention_analytics    = 30
log_retention_storage      = 30

# Configuración de notificaciones externas
sendgrid_api_key_secret    = "sendgrid-api-key"
twilio_account_sid_secret = "twilio-account-sid"
twilio_auth_token_secret  = "twilio-auth-token"
email_from_address        = "notificaciones-qa@empresa.com"
email_from_name           = "Notificaciones QA"