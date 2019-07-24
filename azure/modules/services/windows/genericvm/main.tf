/***************************************************************************
* File Name: instance.tf
* Author: Chun Wu
* Email: the.chun.wu@gmail.com
* Date: July 22, 2019
*
* Purpose: HCL Code (Terraform) that spins up a t2.micro instance. 
* this is highly abstracted as we have setup seperate files to distinguish
* cloud provider, and removed passwords to a seperate file and added it to 
* .gitignore
***************************************************************************/
resource "azurerm_resource_group" "rg" {
  name                          = "${var.RESOURCE_GROUP_NAME}"
  location                      = "${var.AZURE_REGION}"

  tags = {
    version                     = "development"
    build-version               = "${var.TERRAFORM_SCRIPT_VERSION}"
  }
}

# resource "azurerm_virtual_network" "temp_vnet" {
#   name                                        = "${var.RESOURCE_GROUP_NAME}-vnet"
#   location                                    = "${var.AZURE_REGION}"
#   resource_group_name                         = "${azurerm_resource_group.rg.name}"
#   address_space                               = ["${var.VNET_ADDRESS_SPACE}"]
# }

# resource "azurerm_subnet" "temp_subnet" {
#   name                                        = "${var.RESOURCE_GROUP_NAME}-subnet"
#   resource_group_name                         = "${azurerm_resource_group.rg.name}"
#   virtual_network_name                        = "${azurerm_virtual_network.temp_vnet.name}"
#   address_prefix                              = "${var.SUBNET_ADDRESS_PREFIX}"
# }

# resource "azurerm_network_interface" "temp_nic" {
#   name                                        = "${var.SERVER_NAME}-nic"
#   location                                    = "${var.AZURE_REGION}"
#   resource_group_name                         = "${azurerm_resource_group.rg.name}"
#   network_security_group_id                   = "${azurerm_network_security_group.temp_nsg.id}"

#   ip_configuration {
#     name                                      = "${var.SERVER_NAME}-ip"  
#     subnet_id                                 = "${azurerm_subnet.temp_subnet.id}"
#     private_ip_address_allocation             = "dynamic"
#     public_ip_address_id                      = "${azurerm_public_ip.temp_public_ip.id}"
#   }
# }

# resource "azurerm_public_ip" "temp_public_ip" {
#   name                                        = "${var.RESOURCE_GROUP_NAME}-public-ip"
#   location                                    = "${var.AZURE_REGION}"
#   resource_group_name                         = "${azurerm_resource_group.rg.name}"
#   allocation_method                           = "${var.ENVIRONMENT == "development" ? "Static" : "Dynamic"}"
# }

#   resource "azurerm_network_security_group" "temp_nsg" {
#     name                                      = "${var.SERVER_NAME}-nsg"
#     location                                  = "${var.AZURE_REGION}"
#     resource_group_name                       = "${azurerm_resource_group.rg.name}"
#   }

# resource "azurerm_network_security_rule" "temp_nsg_rule_rdp" {
#   name                                        = "RDP Inbound"
#   priority                                    = 100
#   direction                                   = "Inbound"
#   access                                      = "Allow"
#   protocol                                    = "TCP"
#   source_port_range                           = "*"
#   destination_port_range                      = "3389"
#   source_address_prefix                       = "*"
#   destination_address_prefix                  = "*"
#   resource_group_name                         = "${azurerm_resource_group.rg.name}"
#   network_security_group_name                 = "${azurerm_network_security_group.temp_nsg.name}"
# }

# resource "azurerm_virtual_machine" "temp_server" {
#   name                                        = "${var.SERVER_NAME}"
#   location                                    = "${var.AZURE_REGION}"
#   resource_group_name                         = "${azurerm_resource_group.rg.name}"
#   network_interface_ids                       = ["${azurerm_network_interface.temp_nic.id}"]
#   vm_size                                     = "Standard_B1ms"
#   availability_set_id                         = "${azurerm_availability_set.temp_server_availability_set.id}"

#   storage_image_reference {
#     publisher                                 = "MicrosoftWindowsServer"
#     offer                                     = "WindowsServer"
#     sku                                       = "2016-Datacenter-Server-Core-smalldisk"
#     version                                   = "latest"
#   }

#   storage_os_disk {
#     name                                      = "${var.SERVER_NAME}-os-disk"
#     caching                                   = "ReadWrite"
#     create_option                             = "FromImage"
#     managed_disk_type                         = "Standard_LRS"
#   }

#   os_profile {
#     computer_name                             = "${var.SERVER_NAME}"    
#     admin_username                            = "thisisnotadmin"
#     admin_password                            = "Passw0rd!"
#   }

#   os_profile_windows_config {

#   }
# }

# resource "azurerm_availability_set" "temp_server_availability_set" {
#   name                                        = "${var.SERVER_NAME}-availability-set"
#   location                                    = "${var.AZURE_REGION}"
#   resource_group_name                         = "${azurerm_resource_group.rg.name}" 
#   managed                                     = true
#   platform_fault_domain_count                 = 2
# }