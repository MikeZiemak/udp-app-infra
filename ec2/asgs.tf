resource "aws_autoscaling_group" "web_asg" {
  launch_template {
    id      = aws_launch_template.web.id
    version = "$Latest"
  }

  vpc_zone_identifier = [aws_subnet.public.id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  tags = [
    {
      key                 = "Name"
      value               = "web-instance"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "server_asg" {
  launch_template {
    id      = aws_launch_template.server.id
    version = "$Latest"
  }

  vpc_zone_identifier = [aws_subnet.private.id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  tags = [
    {
      key                 = "Name"
      value               = "server-instance"
      propagate_at_launch = true
    }
  ]

  lifecycle {
    create_before_destroy = true
  }
}
