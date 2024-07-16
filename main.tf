provider "aws" {
  region = var.AWS_REGION
}

module "web" {
  source                = "./modules/web"
  VPC_ID                = aws_vpc.main.id
  PUBLIC_SUBNET_ID      = aws_subnet.public.id
  INSTANCE_TYPE         = var.INSTANCE_TYPE
  AMI_ID                = data.aws_ami.latest_arm_ami.id
  WEB_SECURITY_GROUP_ID = aws_security_group.web.id
  CLIENT_PORT           = var.CLIENT_PORT
  CLIENT_IMAGE          = var.CLIENT_IMAGE
  SHARED_TAG            = var.SHARED_TAG
  STARTUP_SCRIPT        = var.CLIENT_STARTUP_SCRIPT
}

module "server" {
  source                   = "./modules/server"
  VPC_ID                   = aws_vpc.main.id
  PRIVATE_SUBNET_ID        = aws_subnet.private.id
  INSTANCE_TYPE            = var.INSTANCE_TYPE
  AMI_ID                   = data.aws_ami.latest_arm_ami.id
  SERVER_SECURITY_GROUP_ID = aws_security_group.server.id
  SERVER_PORT              = var.SERVER_PORT
  SERVER_IMAGE             = var.SERVER_IMAGE
  SHARED_TAG               = var.SHARED_TAG
  STARTUP_SCRIPT           = var.SERVER_STARTUP_SCRIPT
}

