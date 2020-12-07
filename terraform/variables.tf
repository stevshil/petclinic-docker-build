variable "project" {
  type    = string
  default = "petclinic"
}

variable "db_password" {
  type = string
}
variable "dns_suffix" {
  type    = string
  default = "academy.grads.al-labs.co.uk"
}

variable "region" {
  type    = string
  default = "eu-west-1"
}

variable "vpc_cidr" {
  type    = string
  default = "172.31.0.0/16"
}

variable "private_subnets" {
  type    = list(string)
  default = ["172.31.1.0/24", "172.31.2.0/24"]
}

variable "public_subnets" {
  type    = list(string)
  default = ["172.31.10.0/24", "172.31.20.0/24"]
}

variable "office_cidr" {
  type    = list(string)
  default = ["82.24.122.34/32"]
}

variable "ami" {
  default = {
    "eu-west-1" : "ami-0ce1e3f77cd41957e",
    "eu-west-2" : "ami-08b993f76f42c3e2f",
    "us-east-1" : "ami-04d29b6f966df1537",
    "us-west-2" : "ami-0e472933a1395e172"
  }
}

variable "db_backup" {
  default = false
}

variable "iam_policies_jenkins" {
  type = list
  default = [
    "arn:aws:iam::aws:policy/AmazonEC2FullAccess",
    "arn:aws:iam::aws:policy/AmazonS3FullAccess",
    "arn:aws:iam::aws:policy/ElasticLoadBalancingFullAccess",
    "arn:aws:iam::aws:policy/AmazonRoute53FullAccess",
    "arn:aws:iam::aws:policy/AutoScalingFullAccess"
  ]
}

variable "dns_zone_id" {
  type    = string
  default = "Z07626429N74Z31VDFLI"
}
