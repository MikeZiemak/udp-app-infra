output "VPC_ID" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "PUBLIC_SUBNET_ID" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "PRIVATE_SUBNET_ID" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "WEB_ASG_NAME" {
  description = "The name of the web auto scaling group"
  value       = module.web.WEB_ASG_NAME
}

output "SERVER_ASG_NAME" {
  description = "The name of the server auto scaling group"
  value       = module.server.SERVER_ASG_NAME
}

