provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

module "consul" {
  source = "hashicorp/consul/aws"

  aws_region  = "${var.region}" # should match provider region
  num_servers = "3"
}
