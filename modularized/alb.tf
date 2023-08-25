resource "aws_lb_target_group" "hga-lamp-alb-trg" {
  health_check {
    interval            = 10
    path                = "/"
    protocol            = "HTTP"
    timeout             = 5
    healthy_threshold   = 5
    unhealthy_threshold = 2
  }

  name        = "hga-lamp-alb-trg"
  port        = 80
  protocol    = "HTTP"
  target_type = "instance"
  vpc_id      = "aws_vpc.hga-vpc-tf-test.id"
}

resource "aws_lb_target_group_attachment" "hga-lamp-alb-trg-atcmnt1" {
  target_group_arn = "${aws_lb_target_group.hga-lamp-alb-trg.arn}"
  target_id        = "aws_instance.hga-ec2-tf-test-0.id"
  port             = 80
}

resource "aws_lb_target_group_attachment" "hga-lamp-alb-trg-atcmnt2" {
  target_group_arn = "${aws_lb_target_group.hga-lamp-alb-trg.arn}"
  target_id        = "aws_instance.hga-ec2-tf-test-1.id"
  port             = 80
}

resource "aws_alb" "hgalampalb" {
  name     = "hgalampalb"
  internal = false

  security_groups = [
    "${aws_security_group.hga-lamp-alb-sg.id}",
  ]

  subnets = [
    "aws_subnet.hga-subnet-tf-test.id",
  ]

  tags = {
    Name = "hgalampalb"
  }

  ip_address_type    = "ipv4"
  load_balancer_type = "application"
}

resource "aws_lb_listener" "my-test-alb-listner" {
  load_balancer_arn = "${aws_alb.hgalampalb.arn}"
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = "${aws_lb_target_group.hga-lamp-alb-trg.arn}"
  }
}

resource "aws_security_group" "hga-lamp-alb-sg" {
  name   = "hga-lamp-alb-sg"
  vpc_id = "aws_vpc.hga-vpc-tf-test.id"
}

resource "aws_security_group_rule" "inbound_ssh" {
  from_port         = 22
  protocol          = "tcp"
  security_group_id = "${aws_security_group.hga-lamp-alb-sg.id}"
  to_port           = 22
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "inbound_http" {
  from_port         = 80
  protocol          = "tcp"
  security_group_id = "${aws_security_group.hga-lamp-alb-sg.id}"
  to_port           = 80
  type              = "ingress"
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "outbound_all" {
  from_port         = 0
  protocol          = "-1"
  security_group_id = "${aws_security_group.hga-lamp-alb-sg.id}"
  to_port           = 0
  type              = "egress"
  cidr_blocks       = ["0.0.0.0/0"]
}
