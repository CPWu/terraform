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

# AMI = Amazon Image Name, Image ID's often change check websites for AMI ID respective to region.
# ami-dcad28b8 = Centos 7
resource "azurerm_resource_group" "rg" {
  name = "${var.RESOURCE_GROUP_NAME}"
  location = "${var.AZURE_REGION}"
}

resource "azurerm_virtual_network" "temp_vnet" {
  name = "${var.RESOURCE_GROUP_NAME}-vnet"
  location = "${var.AZURE_REGION}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  address_space = ["${var.NETWORK_ADDRESS_SPACE}"]
}

resource "azurerm_subnet" "temp_subnet" {
  name = "${var.RESOURCE_GROUP_NAME}-subnet"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  virtual_network_name = "${azurerm_virtual_network.temp_vnet.name}"
  address_prefix = "${var.NETWORK_ADDRESS_PREFIX}"
}

resource "azurerm_network_interface" "tempServer_nic" {
  name = "${var.RESOURCE_GROUP_NAME}-subnet"
  location = "${var.AZURE_REGION}"
  resource_group_name = "${azurerm_resource_group.rg.name}"

  ip_configuration {
    name = "${var.RESOURCE_GROUP_NAME}-ip"  
    subnet_id = "${azurerm_subnet.temp_subnet.id}"
    private_ip_address_allocation = "dynamic"
    public_ip_address_id = "${azurerm_public_ip.tempServer_public_ip.id}"
  }
}

resource "azurerm_public_ip" "tempServer_public_ip" {
  name = "${var.RESOURCE_GROUP_NAME}-public-ip"
  location = "${var.AZURE_REGION}"
  resource_group_name = "${azurerm_resource_group.rg.name}"
  allocation_method = "Dynamic"
}