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

 resource "azurerm_virtual_network" "DevTest_vnet_rg" {
    name                                = "${var.RESOURCE_GROUP_NAME}-vnet"
    location                            = "${var.AZURE_REGION}"   
    resource_group_name                 = "${var.RESOURCE_GROUP_NAME}"
    address_space                       = ["${var.VNET_ADDRESS_SPACE}"]
}

resource "azurerm_subnet" "JumpSpace_DevTest_subnet_rg" {
    name                                = "JumpSpace-${var.RESOURCE_GROUP_NAME}-subnet"
    resource_group_name                 = "${var.RESOURCE_GROUP_NAME}"
    virtual_network_name                = "${azurerm_virtual_network.DevTest_vnet_rg.name}"
    address_prefix                      = "${var.JUMPSPACE_SUBNET_ADDRESS_PREFIX}"    
}

