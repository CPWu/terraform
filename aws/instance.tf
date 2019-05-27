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

resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
}