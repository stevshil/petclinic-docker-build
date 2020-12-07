resource "aws_launch_configuration" "petclinic" {
  name            = "${var.project}-${terraform.workspace}-lc"
  image_id        = var.ami[var.region]
  instance_type   = "t2.micro"
  security_groups = [data.terraform_remote_state.petclinic.outputs.internal-sg-id]
  key_name        = "${var.project}-${terraform.workspace}"


  user_data = <<EOF
  #!/bin/bash -xv

  yum -y install docker
  echo "{
    \"insecure-registries\": [\""${data.terraform_remote_state.petclinic.outputs.docker_registry_ip}:5000"\"]
  }" >/etc/docker/daemon.json
  systemctl enable docker
  systemctl start docker
  docker run -itd --restart=always --name=petclinic -p8080:8080 -e DBSERVERNAME="${data.terraform_remote_state.petclinic.outputs.db-hostname}" -e DBUSERNAME=petclinic -e DBPASSWORD=$DBPASSWORD "${data.terraform_remote_state.petclinic.outputs.docker_registry_ip}":5000/petclinic:latest
  EOF
}
