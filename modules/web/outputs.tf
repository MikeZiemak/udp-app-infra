output "WEB_ASG_NAME" {
  description = "The name of the web auto scaling group"
  value       = aws_autoscaling_group.web_asg.name
}

