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

variable "CLIENT_IMAGE" {
  description = "Container registry URL (ECR, Dockerhub or otherwise) + image ref"
  default     = "michalziemak/udpapp-web-interface"
}

variable "CLIENT_PORT" {
  description = "Port used by the UDP app server"
  default     = "8081"
}

variable "SERVER_IMAGE" {
  description = "Container registry URL (ECR, Dockerhub or otherwise) + image ref"
  default     = "michalziemak/udpapp-server"
}

variable "SERVER_PORT" {
  description = "Port used by the UDP app server"
  default     = "8080/udp"
}

variable "SHARED_TAG" {
  description = "Tag shared by the client and server"
}

variable "SSH_KEYS" {
  description = "SSH Keys used with the EC2 instances for admin purposes"
  default     = "admin-keys"
}

variable "SERVER_STARTUP_SCRIPT" {
  description = "Startup script (needs to be explicitly base64 encoded to be used)"
}

variable "CLIENT_STARTUP_SCRIPT" {
  description = "Startup script (needs to be explicitly base64 encoded to be used)"
}
