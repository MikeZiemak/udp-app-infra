resource "aws_launch_template" "web" {
  name_prefix   = "web-"
  image_id      = var.AMI_ID
  instance_type = var.INSTANCE_TYPE
  key_name      = var.SSH_KEYS

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = var.PUBLIC_SUBNET_ID
    security_groups             = [var.WEB_SECURITY_GROUP_ID]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-instance"
    }
  }

  user_data = base64encode(var.STARTUP_SCRIPT)
}

resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.PUBLIC_SUBNET_ID]
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1

  lifecycle {
    create_before_destroy = true
  }
}

