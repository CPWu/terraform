/***************************************************************************
* File Name: jumpserver.tf
* Author: Chun Wu
* Email: the.chun.wu@gmail.com
* Date: July 24, 2019
*
* Purpose: Creates a linux server (Ubuntu) for the purposes of using it as 
* a jump server. Port 443 to 22
*
***************************************************************************/

resource "azurerm_resource_group" "DevTest_rg" {
    name                                ="${var.RESOURCE_GROUP_NAME}"
    location                            ="${var.AZURE_REGION}"

    tags = {
        version                         = "DevTest"
        build-version                   = "1.0"
    }  
}

 resource "azurerm_virtual_network" "DevTest_vnet" {
    name                                = "${var.RESOURCE_GROUP_NAME}-vnet"
    location                            = "${var.AZURE_REGION}"   
    resource_group_name                 = "${var.RESOURCE_GROUP_NAME}"
    address_space                       = ["${var.VNET_ADDRESS_SPACE}"]
}

resource "azurerm_subnet" "Space_DevTest_subnet" {
    name                                = "Space-${var.RESOURCE_GROUP_NAME}-subnet"
    resource_group_name                 = "${var.RESOURCE_GROUP_NAME}"
    virtual_network_name                = "${azurerm_virtual_network.DevTest_vnet.name}"
    address_prefix                      = "${var.JUMPSPACE_SUBNET_ADDRESS_PREFIX}"    
}

resource "azurerm_public_ip" "Server-public-ip" {
  name                                        = "${var.RESOURCE_GROUP_NAME}-public-ip"
  location                                    = "${var.AZURE_REGION}"
  resource_group_name                         = "${var.RESOURCE_GROUP_NAME}"
  allocation_method                           = "${var.IP_TYPE}"    
}
resource "azurerm_network_interface" "Server-DevTest-nic" {
    name                                = "${var.SERVER_NAME}-nic"
    location                            = "${var.AZURE_REGION}"
    resource_group_name                 = "${var.RESOURCE_GROUP_NAME}"
    network_security_group_id           = "${azurerm_network_security_group.Server_nsg.id}"

    ip_configuration {
        name                                      = "${var.SERVER_NAME}-ip"  
        subnet_id                                 = "${azurerm_subnet.Space_DevTest_subnet.id}"
        private_ip_address_allocation             = "dynamic"
        public_ip_address_id                      = "${azurerm_public_ip.Server-public-ip.id}"        
    }    
}

resource "azurerm_network_security_group" "Server_nsg" {
name                                      = "${var.SERVER_NAME}-nsg"
location                                  = "${var.AZURE_REGION}"
resource_group_name                       = "${var.RESOURCE_GROUP_NAME}"
}

resource "azurerm_network_security_rule" "Server_nsg_rule_rdp" {
  name                                        = "SSH"
  priority                                    = 100
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "TCP"
  source_port_range                           = "*"
  destination_port_range                      = "22"
  source_address_prefix                       = "*"
  destination_address_prefix                  = "*"
  resource_group_name                         = "${var.RESOURCE_GROUP_NAME}"
  network_security_group_name                 = "${azurerm_network_security_group.Server_nsg.name}"
}

resource "azurerm_virtual_machine" "jumpserver" {
  name                                        = "${var.SERVER_NAME}"
  location                                    = "${var.AZURE_REGION}"
  resource_group_name                         = "${azurerm_resource_group.DevTest_rg.name}"
  network_interface_ids                       = ["${azurerm_network_interface.Server-DevTest-nic.id}"]
  vm_size                                     = "Standard_B1s"

  storage_image_reference {
    publisher                                 = "Canonical"
    offer                                     = "UbuntuServer"
    sku                                       = "16.04.0-LTS"
    version                                   = "latest"
  }

  storage_os_disk {
    name                                      = "${var.SERVER_NAME}-os-disk"
    caching                                   = "ReadWrite"
    create_option                             = "FromImage"
    managed_disk_type                         = "Standard_LRS"
  }

  os_profile {
    computer_name                             = "${var.SERVER_NAME}"    
    admin_username                            = "testuser"
    admin_password                            = "Passw0rd!"
  }

  os_profile_linux_config {
      disable_password_authentication = false
  }
}