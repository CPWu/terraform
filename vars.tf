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
variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
    default = "ca-central-1"
}
variable "AMIS" {
    type = "map"
    default = {
        ca-central-1 = "ami-01b60a3259250381b"
    }
}