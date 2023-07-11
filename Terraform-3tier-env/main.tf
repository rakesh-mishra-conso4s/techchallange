# Configure the Azure provider
provider "azurerm" {
  features {}
}

# Create the resource group
module "resource_group" {
  source              = "../modules/resource_group"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
}

# Create the virtual network
module "virtual_network" {
  source                    = "../modules/virtual_network"
  virtual_network_name      = var.virtual_network_name
  virtual_network_address   = var.virtual_network_address_space
  resource_group_name       = module.resource_group.resource_group_name
  resource_group_location   = module.resource_group.resource_group_location
}

# Create the web subnet
module "web_subnet" {
  source                    = "../modules/subnet"
  subnet_name               = var.web_subnet_name
  subnet_address_prefix     = var.web_subnet_address_prefix
  resource_group_name       = module.resource_group.resource_group_name
  virtual_network_name      = module.virtual_network.virtual_network_name
}

# Create the app subnet
module "app_subnet" {
  source                    = "../modules/subnet"
  subnet_name               = var.app_subnet_name
  subnet_address_prefix     = var.app_subnet_address_prefix
  resource_group_name       = module.resource_group.resource_group_name
  virtual_network_name      = module.virtual_network.virtual_network_name
}

# Create the db subnet
module "db_subnet" {
  source                    = "../modules/subnet"
  subnet_name               = var.db_subnet_name
  subnet_address_prefix     = var.db_subnet_address_prefix
  resource_group_name       = module.resource_group.resource_group_name
  virtual_network_name      = module.virtual_network.virtual_network_name
}

# Create the web network security group
module "web_nsg" {
  source                = "../modules/network_security_group"
  nsg_name              = var.web_nsg_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  subnet_id             = module.web_subnet.subnet_id
  allowed_source        = var.allowed_source_address
}

# Create the app network security group
module "app_nsg" {
  source                = "../modules/network_security_group"
  nsg_name              = var.app_nsg_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  subnet_id             = module.app_subnet.subnet_id
  allowed_source        = var.allowed_source_address
}

# Create the db network security group
module "db_nsg" {
  source                = "../modules/network_security_group"
  nsg_name              = var.db_nsg_name
  resource_group_name   = module.resource_group.resource_group_name
  location              = module.resource_group.resource_group_location
  subnet_id             = module.db_subnet.subnet_id
  allowed_source        = var.allowed_source_address
}
