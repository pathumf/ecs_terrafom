resource "aws_iam_role" "ecs_role" {
  name               = "ecs_role"
  assume_role_policy = "${template_file.ecs_role.rendered}"
}

resource "aws_iam_role_policy" "ecs_instance_role_policy" {
  name     = "ecs_instance_role_policy"
  policy   = "${template_file.ecs_instance_role_policy.rendered}"
  role     = "${aws_iam_role.ecs_role.id}"
}

resource "aws_ecr_repository_policy" "ecr_policy" {
  repository = "${aws_ecr_repository.ecr.name}"
  policy    = "${template_file.ecs_ecr_role_policy.rendered}"
}

resource "aws_iam_instance_profile" "ecs" {
  name = "ecs-instance-profile"
  roles = ["${aws_iam_role.ecs_role.name}"]
}
