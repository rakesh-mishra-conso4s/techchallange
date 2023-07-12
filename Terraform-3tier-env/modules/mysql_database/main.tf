variable "database_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "db_subnet_id" {
  description = "ID of the subnet to associate with the MySQL database"
  type        = string
}

variable "admin_username" {
  description = "Username for the MySQL database"
  type        = string
}

variable "admin_password" {
  description = "Password for the MySQL database"
  type        = string
}

variable "sku_name" {
  description = "Name of the MySQL SKU"
  type        = string
}

variable "sku_capacity" {
  description = "Capacity of the MySQL SKU"
  type        = number
}

output "mysql_database_fully_qualified_domain_name" {
  value = azurerm_mysql_database.testchalnge.fully_qualified_domain_name
}

resource "azurerm_mysql_server" "testchalnge" {
  name                = var.database_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  version             = "5.7"

  sku {
    name     = var.sku_name
    capacity = var.sku_capacity
  }

  storage_profile {
    storage_mb             = 5120
    backup_retention_days  = 7
    geo_redundant_backup   = "Disabled"
    storage_autogrow       = "Enabled"
    storage_iops           = 100
    storage_iops_min       = 0
    storage_iops_max       = 1000
    storage_gb             = 128
  }

  administrator_login          = var.admin_username
  administrator_login_password = var.admin_password

  network_configuration {
    subnet_id = var.db_subnet_id
  }

  ssl_enforcement_enabled     = true
  public_network_access_enabled = false

  depends_on = [
    azurerm_network_security_group.testchalnge
  ]
}

resource "azurerm_mysql_database" "testchalnge" {
  name                = "testchalnge-db"
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mysql_server.testchalnge.name
  charset             = "utf8"
  collation           = "utf8_general_ci"
}
