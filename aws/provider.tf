/***************************************************************************
* File Name: provider.tf
* Author: Chun Wu
* Email: the.chun.wu@gmail.com
* Date: May 26, 2019
*
* Purpose: Configures the credentials for AWS
* 
*
***************************************************************************/

# Region ID: https://docs.aws.amazon.com/general/latest/gr/rande.html
provider "aws" {
  access_key = "${var.AWS_ACCESS_KEY}"
  secret_key = "${var.AWS_SECRET_KEY}"
  region     = "${var.AWS_REGION}"
}