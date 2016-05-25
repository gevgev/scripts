resource "aws_key_pair" "ecs-deployer" {
  key_name     = "ecs-deployer-key"
  public_key = "${file(\"ssh/ecs-deployer-key.pub\")}"
}
