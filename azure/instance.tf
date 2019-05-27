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