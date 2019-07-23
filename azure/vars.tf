
/***************************************************************************
* File Name: vars.tf
* Author: Chun Wu
* Email: the.chun.wu@gmail.com
* Date: July 22, 2019
*
* Purpose: HCL Code (Terraform) that spins up a server instance. 
* this is highly abstracted as we have setup seperate files to distinguish
* cloud provider, and removed passwords to a seperate file and added it to 
* .gitignore
***************************************************************************/

// Provider Variables
variable "SUBSCRIPTION_ID" {}
variable "CLIENT_ID" {}
variable "CLIENT_SECRET" {}
variable "TENANT_ID" {}


// Resource Information
variable "RESOURCE_GROUP_NAME" {}
variable "ENVIRONMENT" {}
// Server Information
variable "AZURE_REGION" {}
variable "SERVER_NAME" {}

// Network Information
variable "VNET_ADDRESS_SPACE" {}
variable "SUBNET_ADDRESS_PREFIX" {}