variable "VPC_ID" {
  description = "The ID of the VPC"
  type        = string
}

variable "PRIVATE_SUBNET_ID" {
  description = "The ID of the private subnet"
  type        = string
}

variable "INSTANCE_TYPE" {
  description = "The instance type to use for the instances"
  type        = string
}

variable "AMI_ID" {
  description = "The AMI ID to use for the instances"
  type        = string
}

variable "SERVER_SECURITY_GROUP_ID" {
  description = "The ID of the server security group"
  type        = string
}

