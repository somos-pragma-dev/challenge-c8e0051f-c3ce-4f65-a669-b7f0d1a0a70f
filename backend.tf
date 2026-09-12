terraform {
  backend "azurerm" {
    resource_group_name  = var.backend_resource_group
    storage_account_name = var.backend_storage_account
    container_name       = var.backend_container_name
    key                  = "notifications/terraform.tfstate"
    use_oidc             = var.use_msi
    use_cli              = !var.use_msi
  }
}