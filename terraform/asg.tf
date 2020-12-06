resource "aws_autoscaling_group" "petclinic" {
  name                      = "${var.project}-${terraform.workspace}-asg"
  max_size                  = 5
  min_size                  = 1
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 1
  force_delete              = true
  launch_configuration      = aws_launch_configuration.petclinic.name
  vpc_zone_identifier       = data.petclinic.outputs.private_subnets
  load_balancers            = [aws_elb.petclinic]


  tags = {
    Name        = "${var.project}-${terraform.workspace}-jenkins"
    Environment = terraform.workspace
  }
}

resource "aws_autoscaling_attachment" "petclinic" {
  autoscaling_group_name = aws_autoscaling_group.petclinic.id
  elb                    = aws_elb.petclinic.id
}