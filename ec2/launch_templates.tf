resource "aws_launch_template" "web" {
  name_prefix   = "web-"
  image_id      = data.aws_ami.latest_arm_ami.id
  instance_type = var.INSTANCE_TYPE

  network_interfaces {
    associate_public_ip_address = true
    subnet_id                   = aws_subnet.public.id
    security_groups             = [aws_security_group.web.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "web-instance"
    }
  }
}

resource "aws_launch_template" "server" {
  name_prefix   = "server-"
  image_id      = data.aws_ami.latest_arm_ami.id
  instance_type = var.INSTANCE_TYPE

  network_interfaces {
    subnet_id       = aws_subnet.private.id
    security_groups = [aws_security_group.server.id]
  }

  tag_specifications {
    resource_type = "instance"
    tags = {
      Name = "server-instance"
    }
  }
}
