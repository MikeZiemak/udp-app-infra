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
}

module "server" {
  source                   = "./modules/server"
  VPC_ID                   = aws_vpc.main.id
  PRIVATE_SUBNET_ID        = aws_subnet.private.id
  INSTANCE_TYPE            = var.INSTANCE_TYPE
  AMI_ID                   = data.aws_ami.latest_arm_ami.id
  SERVER_SECURITY_GROUP_ID = aws_security_group.server.id
}

