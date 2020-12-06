resource "aws_elb" "petclinic" {
  name                      = "${var.project}-${terraform.workspace}-elb"
  availability_zones        = ["${var.region}a", "${var.region}b"]
  security_groups           = [data.petclinic.outputs.webapp-sg-id]
  subnets                   = data.petclinic.outputs.public_subnets
  cross_zone_load_balancing = true

  listener {
    instance_port     = 8080
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 5
    timeout             = 10
    target              = "HTTP:8080/"
    interval            = 60
  }

  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name        = "${var.project}-${terraform.workspace}-jenkins"
    Environment = terraform.workspace
  }
}
