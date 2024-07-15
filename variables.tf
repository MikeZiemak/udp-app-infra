variable "AWS_REGION" {
  description = "The AWS region to deploy to"
  default     = "eu-central-1"
}

variable "VPC_CIDR" {
  description = "The CIDR block for the VPC"
  default     = "10.10.0.0/16"
}

variable "PUBLIC_SUBNET_CIDR" {
  description = "The CIDR block for the public subnet"
  default     = "10.10.5.0/24"
}

variable "PRIVATE_SUBNET_CIDR" {
  description = "The CIDR block for the private subnet"
  default     = "10.10.6.0/24"
}

variable "PUBLIC_SUBNET_AZ" {
  description = "The availability zone for the public subnet"
  default     = "eu-central-1a"
}

variable "PRIVATE_SUBNET_AZ" {
  description = "The availability zone for the private subnet"
  default     = "eu-central-1b"
}

variable "INSTANCE_TYPE" {
  description = "The instance type to use for the instances"
  default     = "t2.micro"
}
