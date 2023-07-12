variable "vmss_name" {
  description = "Name of the virtual machine scale set"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "subnet_id" {
  description = "ID of the subnet to associate with the virtual machine scale set"
  type        = string
}

variable "nsg_id" {
  description = "ID of the network security group to associate with the virtual machine scale set"
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

variable "load_balancer_backend_address_pool_ids" {
  description = "List of load balancer backend address pool IDs"
  type        = list(string)
}

resource "azurerm_linux_virtual_machine_scale_set" "testchalnge" {
  name                = var.vmss_name
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  sku                 = var.vm_sku
  instances           = var.vm_instance_count

  storage_profile_image_reference {
    id = var.vm_image_id
  }

  network_profile {
    name    = "testchalnge-network-profile"
    primary = true

    ip_configuration {
      name                          = "testchalnge-ip-configuration"
      subnet_id                     = var.subnet_id
      load_balancer_backend_address_pool_ids = var.load_balancer_backend_address_pool_ids
    }
  }

  os_profile {
    computer_name_prefix = "testchalnge-vm"
    admin_username       = "adminuser"
    admin_password       = "Password1234!"
  }

  os_profile_linux_config {
    disable_password_authentication = false
  }

  upgrade_mode = "Automatic"

  extension {
    name                 = "customScript"
    publisher            = "Microsoft.Azure.Extensions"
    type                 = "CustomScript"
    type_handler_version = "2.1"

    protected_settings = <<SETTINGS
    {
        "commandToExecute": "echo Hello World > /tmp/hello.txt"
    }
    SETTINGS

    settings = <<SETTINGS
    {
        "fileUris": [
            "https://path/to/custom_script.sh"
        ]
    }
    SETTINGS
  }

  depends_on = [
    azurerm_network_security_group.testchalnge
  ]
}
