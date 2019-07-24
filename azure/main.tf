/***************************************************************************
* File Name: provider.tf
* Author: Chun Wu
* Email: the.chun.wu@gmail.com
* Date: May 26, 2019
*
* Purpose: Configures the credentials for Azure
* 
*
***************************************************************************/

provider "azurerm" {
    version = "1.31"
    client_id = "${var.CLIENT_ID}"
    client_secret = "${var.CLIENT_SECRET}"
    tenant_id = "${var.TENANT_ID}"
    subscription_id = "${var.SUBSCRIPTION_ID}"
}

module "jumpserver" {
    source = "./modules/services/linux/jumpserver"
    AZURE_REGION = "canadacentral"
    RESOURCE_GROUP_NAME = "DevTest-rg"
    VNET_ADDRESS_SPACE = "10.0.0.0/16"
    JUMPSPACE_SUBNET_ADDRESS_PREFIX = "10.0.2.0/24"
    SERVER_NAME = "jumpserver"
    IP_TYPE = "Static"
}
