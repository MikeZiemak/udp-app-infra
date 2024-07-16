resource "aws_lb" "udp_nlb" {
  name               = "udp-nlb"
  internal           = true
  load_balancer_type = "network"
  subnets            = [aws_subnet.private.id]

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "udp_target_group" {
  name        = "udp-tg"
  port        = 8080
  protocol    = "UDP"
  vpc_id      = aws_vpc.main.id
  target_type = "instance"

  health_check {
    protocol = "TCP"
    port     = "6666"
  }
}

resource "aws_lb_listener" "udp_listener" {
  load_balancer_arn = aws_lb.udp_nlb.arn
  port              = 8080
  protocol          = "UDP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.udp_target_group.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = module.server.SERVER_ASG_NAME
  lb_target_group_arn    = aws_lb_target_group.udp_target_group.arn
}


