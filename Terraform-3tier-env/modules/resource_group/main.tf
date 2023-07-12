variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Location for the resource group"
  type        = string
}

output "resource_group_name" {
  value = azurerm_resource_group.testchalnge.name
}

output "resource_group_location" {
  value = azurerm_resource_group.testchalnge.location
}

resource "azurerm_resource_group" "testchalnge" {
  name     = var.resource_group_name
  location = var.resource_group_location
}
