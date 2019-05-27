/***************************************************************************
* File Name: vars.tf
* Author: Chun Wu
* Email: the.chun.wu@gmail.com
* Date: May 26, 2019
*
* Purpose: Defines all the variables used by HCL (Terraform) code.
* 
*
***************************************************************************/
variable "CLIENT_ID" {}
variable "CLIENT_SECRET" {}
variable "TENANT_ID" {}
variable "SUBSCRIPTION_ID" {}
variable "AZURE_REGION" {
    default = "canadaeast"
}
variable "RESOURCE_GROUP_NAME" {}
variable "RESOURCE_GROUP_PREFIX" {}
variable "NETWORK_ADDRESS_SPACE" {}