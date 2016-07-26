resource "aws_autoscaling_group" "etcd" {
  name = "etcd-${var.environment}"
  min_size = "${var.cluster_size}"
  max_size = "${var.cluster_size}"
  desired_capacity = "${var.cluster_size}"
  launch_configuration = "${aws_launch_configuration.etcd.id}"
  load_balancers = ["${aws_elb.etcd.id}"]
  health_check_type = "ELB"
  wait_for_elb_capacity = "${var.cluster_size}"
  vpc_zone_identifier = ["${split(",", terraform_remote_state.vpc.output.private_subnet_ids)}"]
  tag {
    key = "Name"
    value = "etcd-${var.environment}"
    propagate_at_launch = true
  }
  tag {
    key = "Environment"
    value = "${var.environment}"
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}