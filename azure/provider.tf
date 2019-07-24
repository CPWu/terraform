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

module "genericvm" {
    source = "./modules/services/windows/genericvm"
}
