resource "aws_launch_template" "server" {
  name_prefix   = "server-"
  image_id      = var.AMI_ID
  instance_type = var.INSTANCE_TYPE

  network_interfaces {
    subnet_id       = var.PRIVATE_SUBNET_ID
    security_groups = [var.SERVER_SECURITY_GROUP_ID]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "server-instance"
    }
  }

}

resource "aws_autoscaling_group" "server_asg" {
  launch_template {
    id      = aws_launch_template.server.id
    version = "$Latest"
  }

  vpc_zone_identifier = [var.PRIVATE_SUBNET_ID]
  desired_capacity    = 1
  max_size            = 2
  min_size            = 1

  lifecycle {
    create_before_destroy = true
  }
}

