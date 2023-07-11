variable "subnet_name" {
  description = "Name of the subnet"
  type        = string
}

variable "subnet_address_prefix" {
  description = "Address prefix for the subnet"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

output "subnet_id" {
  value = azurerm_subnet.example.id
}

resource "azurerm_subnet" "example" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = [var.subnet_address_prefix]
}
