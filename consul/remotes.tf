resource "terraform_remote_state" "vpc" {
  backend = "s3"
  config {
    region = "${var.s3_region}"
    bucket = "${var.s3_bucket}"
    key = "${var.environment}/vpc.tfstate"
  }
}

resource "terraform_remote_state" "bastion" {
  backend = "s3"
  config {
    region = "${var.s3_region}"
    bucket = "${var.s3_bucket}"
    key = "${var.environment}/bastion.tfstate"
  }
}