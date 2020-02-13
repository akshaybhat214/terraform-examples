resource "aws_ecs_cluster" "dummy-cluster" {
  name = "dummy-${var.environment}"
  setting  {
    name = "containerInsights"
    value = "enabled"
  }

  tags = {
    Product = "${var.product}"
    Env     = "${var.environment}"
  }
}

resource "aws_ecs_task_definition" "app" {
  family                   = "dummy-task-${var.environment}"
  execution_role_arn       = "${data.aws_iam_role.ecs_task_execution_role.arn}"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  cpu                      = "${var.fargate_cpu}"
  memory                   = "${var.fargate_memory}"
  container_definitions    = "${data.template_file.dummy_app.rendered}"

  tags = {
    Product = "${var.product}"
    Env     = "${var.environment}"
  }
}

resource "aws_ecs_service" "main-service" {
  name            = "dummy-ecs-service-${var.environment}"
  cluster         = "${aws_ecs_cluster.dummy-cluster.id}"
  task_definition = "${aws_ecs_task_definition.app.arn}"
  desired_count   = "${var.app_count}"
  launch_type     = "FARGATE"

  network_configuration {
    assign_public_ip = true
    subnets = ["${var.subnet_1}","${var.subnet_2}"]
  }

  tags = {
    Product = "${var.product}"
    Env     = "${var.environment}"
  }
}

data "aws_iam_role" "ecs_task_execution_role" {
  role_name = "${var.ecs_role_name}"
}

data "template_file" "dummy_app" {
  template = "${file("./templates/dummy_app.json.tpl")}"

  vars = {
    aws_region      = "${var.region}"
    release         = "${var.release_version}"
    app_image       = "${var.app_image}"
    app_port        = "${var.app_port}"
    fargate_cpu     = "${var.fargate_cpu}"
    fargate_memory  = "${var.fargate_memory}"
    environment     = "${var.environment}"
  }

}


