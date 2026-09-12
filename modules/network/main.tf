terraform {
  required_version = ">= 1.5"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}

resource "azurerm_virtual_network" "main_vnet" {
  name                = "vnet-${var.environment}-${var.location_short}"
  address_space       = var.vnet_address_space
  location            = var.location
  resource_group_name = var.resource_group_name

  dns_servers = var.dns_servers

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "networking"
      cost_center = var.cost_center
    }
  )
}

resource "azurerm_subnet" "subnet_public" {
  name                                           = "snet-public"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.public_subnet_prefixes
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = true

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.KeyVault"
  ]

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet" "subnet_private" {
  name                                           = "snet-private"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.private_subnet_prefixes
  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = false

  delegation {
    name = "delegation"

    service_delegation {
      name = "Microsoft.Web/serverFarms"
      actions = [
        "Microsoft.Network/virtualNetworks/subnets/action"
      ]
    }
  }

  service_endpoints = [
    "Microsoft.Storage",
    "Microsoft.Sql",
    "Microsoft.KeyVault",
    "Microsoft.EventHub",
    "Microsoft.ServiceBus"
  ]

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet" "subnet_database" {
  name                                           = "snet-database"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.database_subnet_prefixes
  private_endpoint_network_policies_enabled     = true
  private_link_service_network_policies_enabled = false

  service_endpoints = [
    "Microsoft.Storage"
  ]

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet" "subnet_app_gateway" {
  name                                           = "snet-app-gateway"
  resource_group_name                            = var.resource_group_name
  virtual_network_name                           = azurerm_virtual_network.main_vnet.name
  address_prefixes                               = var.app_gateway_subnet_prefixes
  private_endpoint_network_policies_enabled     = false
  private_link_service_network_policies_enabled = false

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_network_security_group" "nsg_public" {
  name                = "nsg-public-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-HTTPS-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-HTTP-Inbound"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "80"
    source_address_prefix      = "Internet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-AppGateway-Inbound"
    priority                   = 120
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "65200-65535"
    source_address_prefix      = "AzureApplicationGatewaySubnet"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-AzureLoadBalancer-Inbound"
    priority                   = 130
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VNet-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow-Internet-Outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  security_rule {
    name                       = "Allow-AzureStorage-Outbound"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Storage"
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "network-security"
    }
  )
}

resource "azurerm_network_security_group" "nsg_private" {
  name                = "nsg-private-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-VNet-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "VirtualNetwork"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow-AppGateway-To-App"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "10.0.1.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-BlobStorage-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Storage"
  }

  security_rule {
    name                       = "Allow-KeyVault-Outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "KeyVault"
  }

  security_rule {
    name                       = "Allow-SQL-Outbound"
    priority                   = 120
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "*"
    destination_address_prefix = "Sql"
  }

  security_rule {
    name                       = "Allow-Internet-Outbound"
    priority                   = 130
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Internet"
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "network-security"
    }
  )
}

resource "azurerm_network_security_group" "nsg_database" {
  name                = "nsg-database-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow-PrivateSubnet-Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "10.0.2.0/24"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-AzureServices-SQL"
    priority                   = 110
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "1433"
    source_address_prefix      = "AzureLoadBalancer"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "Allow-VNet-Outbound"
    priority                   = 100
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "VirtualNetwork"
  }

  security_rule {
    name                       = "Allow-Storage-Outbound"
    priority                   = 110
    direction                  = "Outbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "443"
    source_address_prefix      = "*"
    destination_address_prefix = "Storage"
  }

  tags = merge(
    var.common_tags,
    {
      environment = var.environment
      component   = "network-security"
    }
  )
}

resource "azurerm_subnet_network_security_group_association" "nsg_public_assoc" {
  subnet_id                 = azurerm_subnet.subnet_public.id
  network_security_group_id = azurerm_network_security_group.nsg_public.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_private_assoc" {
  subnet_id                 = azurerm_subnet.subnet_private.id
  network_security_group_id = azurerm_network_security_group.nsg_private.id
}

resource "azurerm_subnet_network_security_group_association" "nsg_database_assoc" {
  subnet_id                 = azurerm_subnet.subnet_database.id
  network_security_group_id = azurerm_network_security_group.nsg_database.id
}

resource "azurerm_route_table" "private_routes" {
  name                = "rt-private-${var.environment}"
  location            = var.location
  resource_group_name = var.resource_group_name

  route {
    name                   = "to-internet"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "Internet"
  }

  route {
    name                   = "to-on-premises"
    address_prefix         = var.on_premises_address_space
    next_hop_type          = "VnetLocal"
  }

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_subnet_route_table_association" "private_routes_assoc" {
  subnet_id      = azurerm_subnet.subnet_private.id
  route_table_id = azurerm_route_table.private_routes.id
}

resource "azurerm_private_dns_zone" "private_dns" {
  name                = "${var.environment}.${var.dns_zone_name}"
  resource_group_name = var.resource_group_name

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_vnet_link" {
  name                  = "${azurerm_virtual_network.main_vnet.name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.private_dns.name
  virtual_network_id    = azurerm_virtual_network.main_vnet.id
  registration_enabled  = false

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}

resource "azurerm_network_watcher" "network_watcher" {
  name                = "nw-${var.environment}-${var.location_short}"
  location            = var.location
  resource_group_name = var.resource_group_name

  tags = merge(
    var.common_tags,
    { environment = var.environment }
  )
}