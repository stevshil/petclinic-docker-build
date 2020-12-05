resource "aws_launch_configuration" "petclinic" {
  name            = "${var.project}-${terraform.workspace}-lc"
  image_id        = var.ami[var.region]
  instance_type   = "t2.micro"
  security_groups = [data.petclinic.outputs.internal-sg-id]


  user_data = <<EOF
  #!/bin/bash -xv

  yum -y install docker
  echo "{
    insecure-registries: ["${data.petclinic.outputs.docker_registry_ip}:5000"]
    }" >/etc/docker/daemon.json
  systemctl enable docker
  systemctl start docker
  docker run -itd --restart=always --name=petclinic -p8080:8080 "${data.petclinic.outputs.docker_registry_ip}":5000/petclinic:latest
  EOF

  tags = {
    Name        = "${var.project}-${terraform.workspace}-jenkins"
    Environment = terraform.workspace
  }
}
