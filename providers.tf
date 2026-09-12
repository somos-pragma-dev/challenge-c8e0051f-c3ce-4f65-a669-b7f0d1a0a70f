terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    time = {
      source  = "hashicorp/time"
      version = "~> 0.9"
    }
  }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy = true
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = true
    }
    virtual_machine {
      delete_os_disk_on_deletion = true
    }
    container_registry {
      purge_soft_delete_on_destroy = true
    }
  }

  skip_provider_registration = false
  use_msi                        = true
  use_cli                         = false
  use_oidc                        = false

  subscription_id = var.subscription_id
  tenant_id       = var.tenant_id
  client_id       = var.client_id
  client_secret   = var.client_secret
}

provider "random" {
  version = "~> 3.5"
}

provider "time" {
  version = "~> 0.9"
}

variable "subscription_id" {
  description = "ID de la suscripción de Azure donde se desplegará la infraestructura"
  type        = string
  sensitive   = true
}

variable "tenant_id" {
  description = "ID del tenant de Azure Active Directory"
  type        = string
  sensitive   = true
}

variable "client_id" {
  description = "ID del cliente de la Service Principal utilizada para autenticación"
  type        = string
  sensitive   = true
}

variable "client_secret" {
  description = "Secreto del cliente de la Service Principal"
  type        = string
  sensitive   = true
}