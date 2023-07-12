variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "resource_group_location" {
  description = "Location for the resource group"
  type        = string
  default     = "West Europe"
}

variable "virtual_network_name" {
  description = "Name of the virtual network"
  type        = string
}

variable "virtual_network_address_space" {
  description = "Address space for the virtual network"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "web_subnet_name" {
  description = "Name of the web subnet"
  type        = string
}

variable "web_subnet_address_prefix" {
  description = "Address prefix for the web subnet"
  type        = string
  default     = "10.0.1.0/24"
}

variable "app_subnet_name" {
  description = "Name of the application subnet"
  type        = string
}

variable "app_subnet_address_prefix" {
  description = "Address prefix for the application subnet"
  type        = string
  default     = "10.0.2.0/24"
}

variable "db_subnet_name" {
  description = "Name of the database subnet"
  type        = string
}

variable "db_subnet_address_prefix" {
  description = "Address prefix for the database subnet"
  type        = string
  default     = "10.0.3.0/24"
}

variable "web_nsg_name" {
  description = "Name of the web subnet network security group"
  type        = string
}

variable "app_nsg_name" {
  description = "Name of the application subnet network security group"
  type        = string
}

variable "db_nsg_name" {
  description = "Name of the database subnet network security group"
  type        = string
}

variable "allowed_source_address" {
  description = "Source IP address or range allowed to access the web and application tiers"
  type        = string
}

variable "storage_account_name" {
  description = "Name of the Azure Storage Account for state storage"
  type        = string
}

variable "container_name" {
  description = "Name of the Azure Blob Storage container for state storage"
  type        = string
}

variable "vmss_name" {
  description = "Name of the virtual machine scale set"
  type        = string
}

variable "vm_image_id" {
  description = "ID of the VM image"
  type        = string
}

variable "vm_sku" {
  description = "SKU of the virtual machine"
  type        = string
}

variable "vm_instance_count" {
  description = "Number of virtual machine instances"
  type        = number
}

variable "database_name" {
  description = "Name of the MySQL database"
  type        = string
}

variable "mysql_admin_username" {
  description = "Username for the MySQL database"
  type        = string
}

variable "mysql_admin_password" {
  description = "Password for the MySQL database"
  type        = string
}

variable "mysql_sku_name" {
  description = "Name of the MySQL SKU"
  type        = string
}

variable "mysql_sku_capacity" {
  description = "Capacity of the MySQL SKU"
  type        = number
}
