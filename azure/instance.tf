/***************************************************************************
* File Name: instance.tf
* Author: Chun Wu
* Email: the.chun.wu@gmail.com
* Date: May 26, 2019
*
* Purpose: HCL Code (Terraform) that spins up a t2.micro instance. 
* this is highly abstracted as we have setup seperate files to distinguish
* cloud provider, and removed passwords to a seperate file and added it to 
* .gitignore
***************************************************************************/
resource "azurerm_resource_group" "rg" {
  name                          = "${var.RESOURCE_GROUP_NAME}"
  location                      = "${var.AZURE_REGION}"
}

resource "azurerm_virtual_network" "temp_vnet" {
  name                                        = "${var.RESOURCE_GROUP_NAME}-vnet"
  location                                    = "${var.AZURE_REGION}"
  resource_group_name                         = "${azurerm_resource_group.rg.name}"
  address_space                               = ["${var.VNET_ADDRESS_SPACE}"]
}

resource "azurerm_subnet" "temp_subnet" {
  name                                        = "${var.RESOURCE_GROUP_NAME}-subnet"
  resource_group_name                         = "${azurerm_resource_group.rg.name}"
  virtual_network_name                        = "${azurerm_virtual_network.temp_vnet.name}"
  address_prefix                              = "${var.SUBNET_ADDRESS_PREFIX}"
}

resource "azurerm_network_interface" "temp_nic" {
  name                                        = "${var.SERVER_NAME}-nic"
  location                                    = "${var.AZURE_REGION}"
  resource_group_name                         = "${azurerm_resource_group.rg.name}"
  network_security_group_id                   = "${azurerm_network_security_group.tempServer_nsg.id}"

  ip_configuration {
    name                                      = "${var.SERVER_NAME}-ip"  
    subnet_id                                 = "${azurerm_subnet.temp_subnet.id}"
    private_ip_address_allocation             = "dynamic"
    public_ip_address_id                      = "${azurerm_public_ip.tempServer_public_ip.id}"
  }
}

resource "azurerm_public_ip" "tempServer_public_ip" {
  name                                        = "${var.RESOURCE_GROUP_NAME}-public-ip"
  location                                    = "${var.AZURE_REGION}"
  resource_group_name                         = "${azurerm_resource_group.rg.name}"
  allocation_method                           = "${var.ENVIRONMENT == "development" ? "Static" : "Dynamic"}"
}

  resource "azurerm_network_security_group" "tempServer_nsg" {
    name                                      = "${var.SERVER_NAME}-nsg"
    location                                  = "${var.AZURE_REGION}"
    resource_group_name                       = "${azurerm_resource_group.rg.name}"
  }

resource "azurerm_network_security_rule" "tempServer_nsg_rule_rdp" {
  name                                        = "RDP Inbound"
  priority                                    = 100
  direction                                   = "Inbound"
  access                                      = "Allow"
  protocol                                    = "TCP"
  source_port_range                           = "*"
  destination_port_range                      = "3389"
  source_address_prefix                       = "*"
  destination_address_prefix                  = "*"
  resource_group_name                         = "${azurerm_resource_group.rg.name}"
  network_security_group_name                 = "${azurerm_network_security_group.tempServer_nsg.name}"
}

