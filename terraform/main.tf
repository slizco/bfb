provider "aws" {
  region  = "us-east-1"
  profile = "liz"
}

terraform {
  backend "s3" {
    bucket  = "slizco-tfstate"
    key     = "dev/bfb/terraform.tfstate"
    region  = "us-east-1"
    profile = "liz"
  }
}

resource "aws_ecs_service" "bfb" {
  name            = "bfb"
  cluster         = "dev"
  task_definition = "${aws_ecs_task_definition.bfb.arn}"
  desired_count   = 1
  launch_type     = "FARGATE"

  network_configuration = {
    subnets          = "${var.subnets}"
    security_groups  = "${var.security_groups}"
    assign_public_ip = true
  }
}

resource "aws_ecs_task_definition" "bfb" {
  family                   = "bfb"
  container_definitions    = "${file("container_defs.json")}"
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = 512
  memory                   = 1024

  task_role_arn      = "arn:aws:iam::${var.account_id}:role/task-role-bfb"
  execution_role_arn = "arn:aws:iam::${var.account_id}:role/task-role-bfb"
}
