resource "aws_ecr_repository" "repository" {
  name = "${local.name}-repository"
}
