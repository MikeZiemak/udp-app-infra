output "SERVER_ASG_NAME" {
  description = "The name of the server auto scaling group"
  value       = aws_autoscaling_group.server_asg.name
}

