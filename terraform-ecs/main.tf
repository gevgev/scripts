provider "aws" {
  access_key  = "${var.access_key}"
  secret_key  = "${var.secret_key}"
  region      = "${var.region}"
}

resource "aws_ecs_cluster" "parser-cluster" {
  name="parser-cluster"
}

resource "aws_ecs_task_definition" "s3-worker-task" {
  family = "s3-pusher"
  container_definitions = "${file("task-definitions/worker-task.json")}"

  volume {
    name = "worker-instance"
  }
}

resource "aws_ecs_service" "parser-to-s3-service" {
  name = "parser-to-s3-service"
  cluster = "${aws_ecs_cluster.parser-cluster.id}"
  task_definition = "${aws_ecs_task_definition.s3-worker-task.arn}"
  desired_count = "${var.instances}"
}

/* cluster servers */
resource "aws_instance" "ec2_cluster_instance" {
  count = "${var.instances}"
  ami = "${lookup(var.amis, var.region)}"
  instance_type = "t2.micro"
  subnet_id = "${var.subnet_id}"
  vpc_security_group_ids = ["${var.vpc_security_group_id}"]
  key_name = "${aws_key_pair.ecs-deployer.key_name}"
  source_dest_check = false
  tags = { 
    Name = "ecs-cluster-server-${count.index}"
  }
  connection {
    user = "ec2-user"
    key_file = "ssh/ecs-deployer-key"
  }
  provisioner "remote-exec" {
    inline = [
      "sudo sh -c 'echo ECS_CLUSTER=${aws_ecs_service.parser-to-s3-service.name} >> /etc/ecs/ecs.config' "
    ]
  }
}

/* from https://groups.google.com/forum/#!topic/terraform-tool/K58CBHhLX9g

resource "aws_iam_role" "proxy" {
    name = "ecs-instance-role"
    assume_role_policy = <<EOF
{
  "Version": "2008-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF
}

resource "aws_iam_policy_attachment" "proxy" {
    name = "proxy"
    roles = ["${aws_iam_role.proxy.name}"]
    policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}

*/