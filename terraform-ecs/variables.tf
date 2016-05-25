variable "access_key" { 
  description = "AWS access key"
}

variable "secret_key" { 
  description = "AWS secret access key"
}

variable "region"     				{ default = "us-west-2" }
variable "zone" 					    { default = "us-west-2a"}
variable "vpc_id"       			{ default = "vpc-a88757cc" }
variable "subnet_id"    			{ default = "subnet-dde815ab" }
variable "vpc_security_group_id"    { default = "sg-74f8ac13" }

/* Ubuntu 14.04 amis by region */
variable "amis" {
  description = "Base ECS optimized AMI to launch the instances with"
  default = {
    us-west-2 = "ami-847785e4" /* ami-847785e4, ami-a28476c2 */
  }
}

/* commenting out for now - testing ecs only */

variable "instances" {
	description = "Number of angoss worker instances to launch. 0 = shut down everything"
  default = 1
}

variable "ftp-folder" {
	description = "FTP path to folder"
  default = "/iGuide/Click"
}

variable "ftp-file" {
	description = "File name"
  default = "Click-Tacoma-test.zip"
}

variable "s3-bucket" {
	description = "Target S3 bucket full name"
  default = "r31analysis/click"
}

variable "ftp-url" {
	description = "FTP URL"
	default = "ftp://adsawsftp:quickaccess123@ec2-52-24-138-152.us-west-2.compute.amazonaws.com"
}
