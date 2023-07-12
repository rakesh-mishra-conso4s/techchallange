variable "nsg_name" {
  description = "Name of the network security group"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "location" {
  description = "Location for the network security group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to associate with the network security group"
  type        = string
}

variable "allowed_source" {
  description = "Source IP address or range allowed to access the subnet"
  type        = string
}

output "nsg_id" {
  value = azurerm_network_security_group.testchalnge.id
}

resource "azurerm_network_security_group" "testchalnge" {
  name                = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name

  security_rule {
    name                       = "Allow_All_Inbound"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = var.allowed_source
    destination_address_prefix = "*"
  }

  subnet {
    id = var.subnet_id
  }
}
