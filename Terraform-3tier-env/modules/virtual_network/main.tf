variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "virtual_network_address" {
  description = "Address space for the virtual network"
  type        = list(string)
}

output "virtual_network_name" {
  value = azurerm_virtual_network.example.name
}

resource "azurerm_virtual_network" "example" {
  name                = var.virtual_network_name
  address_space       = var.virtual_network_address
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}
