# ==============================================================================
# Valores específicos para el ambiente de PRODUCCIÓN
# Servicio de Notificaciones en Azure
# Optimizado para alta disponibilidad, rendimiento y seguridad
# ==============================================================================

# Configuración general del ambiente
environment                = "prod"
location                   = "eastus2"
project_name               = "notificaciones"

# Grupo de recursos
resource_group_name         = "rg-notificaciones-prod"
resource_group_location    = "eastus2"

# Configuración de red - Topología de alta disponibilidad
vnet_cidr                  = "10.2.0.0/16"
subnet_functions_cidr      = "10.2.1.0/24"
subnet_private_endpoints   = "10.2.2.0/24"
subnet_gateway_cidr        = "10.2.3.0/28"
dns_zone_name              = "notificaciones.empresa.com"

# Configuración de Azure Functions - Premium para HA
function_app_name          = "func-notificaciones-prod"
function_app_sku           = "Premium"
function_app_capacity      = 2
function_app_os_type       = "Linux"
function_app_runtime       = "python"
function_app_runtime_version = "4"
app_service_plan_name      = "asp-notificaciones-prod"
always_on                  = true
premium_plan_tier          = "EP2"
vnet_integration_subnet   = "functions"

# Configuración de Storage Account para colas de notificaciones - Geo-Redundant
storage_account_name       = "stonotificacionesprd"
storage_account_tier       = "Standard"
storage_account_replication = "GRS"
storage_account_kind       = "StorageV2"
queue_name                 = "notificaciones-queue"
enable_https_traffic_only  = true

# Configuración de Azure Key Vault - Premium para mayor seguridad
key_vault_name             = "kv-notificaciones-prod"
key_vault_sku              = "premium"
enable_soft_delete         = true
soft_delete_retention_days = 90
enable_purge_protection    = true
network_acls_bypass        = "AzureServices"

# Configuración de seguridad - Máximo nivel
enable_private_endpoint    = true
enable_vnet_integration    = true
allowed_ingress_ips        = ["10.2.0.0/16"]
enable_role_assignment     = true
enable_identity            = true
use_managed_identity      = true

# Configuración de alta disponibilidad y redundancia
high_availability_enabled  = true
geo_redundant_enabled      = true
backup_enabled             = true
rto_minutes                = 15
rpo_minutes                = 5
cross_region_restore       = true

# Configuración de desastres y recuperación
disaster_recovery_location = "westus2"
backup_vault_name          = "bv-notificaciones-prod"
backup_policy_daily        = true
backup_policy_weekly       = true
backup_retention_days      = 30

# Configuración de monitoreo y logging - Completo
log_analytics_workspace_name = "law-notificaciones-prod"
log_analytics_retention_days = 90
enable_app_insights        = true
app_insights_name          = "appi-notificaciones-prod"
app_insights_sampling      = 100
enable_proactive_detection = true

# Configuración de alertas - Críticas
alert_email_recipients     = ["sre-oncall@empresa.com", "notificaciones-prod@empresa.com", "cloudops@empresa.com", "security@empresa.com"]
alert_severity_threshold   = "critical"
enable_health_check        = true
health_check_interval      = 15
alert_sms_enabled          = true
sms_oncall_numbers         = ["+1234567890"]

# Configuración de escalabilidad automática - Optimizada
auto_scale_enabled         = true
min_instances              = 3
max_instances              = 20
scale_threshold_cpu        = 50
scale_threshold_requests   = 500
scale_up_cool_down_minutes = 3
scale_down_cool_down_minutes = 10

# Configuración de rendimiento
function_timeout_seconds   = 230
max_memory_mb              = 1536
connection_limit           = 100

# Configuración de cifrado - Máximo nivel
encryption_at_rest_enabled = true
tls_version                = "1.3"
enable_customer_managed_key = true
key_vault_key_name         = "cmk-notificaciones"

# Configuración de certificados SSL
ssl_cert_secret_name       = "ssl-cert-notificaciones"
ssl_cert_key_vault         = "kv-notificaciones-prod"

# Configuración de etiquetas (tags) para costos y gobierno
tags = {
  Environment     = "Production"
  Owner           = "SRE Team"
  CostCenter      = "IT-Produccion"
  Project         = "Notificaciones"
  ManagedBy       = "Terraform"
  Compliance      = "PCI-DSS"
  DataSensitivity = "High"
  BackupRequired  = "true"
  DRTier          = "Gold"
  SLA             = "99.95"
  SupportTier     = "24x7"
}

# Configuración de red avanzada
enable_network_isolation   = true
use_private_dns            = true
dns_forwarder_enabled      = true
enable_ddos_protection     = true

# Configuración de políticas de acceso
api_key_required           = true
api_key_rotation_days      = 30
enable_mtls                = true
require_approved_clients   = true
ip_whitelist_enabled       = true

# Configuración de retención de logs
diagnostic_retention_days  = 90
log_retention_analytics    = 90
log_retention_storage      = 90
audit_logs_enabled         = true

# Configuración de notificaciones externas - Múltiples proveedores
sendgrid_api_key_secret    = "sendgrid-api-key"
twilio_account_sid_secret = "twilio-account-sid"
twilio_auth_token_secret  = "twilio-auth-token"
email_from_address        = "notificaciones@empresa.com"
email_from_name           = "Notificaciones Empresariales"
fallback_provider_enabled  = true
fallback_provider_name     = "sendgrid"

# Configuración de rate limiting
rate_limit_enabled         = true
rate_limit_requests        = 1000
rate_limit_window_seconds  = 60
rate_limit_burst           = 100

# Configuración de caché
redis_cache_enabled        = true
redis_cache_name           = "rcache-notificaciones-prod"
redis_cache_sku           = "Premium"
redis_cache_tier          = "P1"
redis_cache_family        = "C"

# Configuración de integración con servicios externos
webhook_enabled            = true
webhook_timeout_seconds    = 30
webhook_retry_count        = 3
webhook_retry_delay_seconds = 60