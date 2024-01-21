#create load balancer

resource "aws_lb" "pub-sub-alb" {
  name            = var.load_balancer_name
  subnets         = [aws_subnet.public_sub_1.id, aws_subnet.public_sub_2.id]
  security_groups = [aws_security_group.ALB_SG.id]

  tags = {
    Name = "Pub-Sub-ALB"
  }
}

#create target group

resource "aws_lb_target_group" "alb-tg" {
  name     = var.target_group_name
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.vpc_for_tera.id


  health_check {
    interval = 60
    path     = "/"
    port     = 80
    timeout  = 45
    protocol = "HTTP"
    matcher  = "200,202"
  }
}

resource "aws_lb_listener" "alb-listener" {
  load_balancer_arn = aws_lb.pub-sub-alb.arn
  port              = "80"
  protocol          = "HTTP"

  # Set the default action for the listener
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.alb-tg.arn
  }
}