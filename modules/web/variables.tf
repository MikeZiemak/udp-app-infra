variable "VPC_ID" {
  description = "The ID of the VPC"
  type        = string
}

variable "PUBLIC_SUBNET_ID" {
  description = "The ID of the public subnet"
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

variable "WEB_SECURITY_GROUP_ID" {
  description = "The ID of the web security group"
  type        = string
}

variable "CLIENT_IMAGE" {
  description = "Container registry URL (ECR, Dockerhub or otherwise) + image ref"
}

variable "CLIENT_PORT" {
  description = "Port used by the UDP app server"
}

variable "SHARED_TAG" {
  description = "Tag shared by the client and server"
}

variable "SSH_KEYS" {
  description = "SSH Keys used with the EC2 instances for admin purposes"
  default     = "admin-keys"
}

