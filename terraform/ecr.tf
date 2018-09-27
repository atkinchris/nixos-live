resource "aws_ecr_repository" "repository" {
  name = "${local.name}-repository"
}

resource "aws_ecr_repository_policy" "repository" {
  repository = "${aws_ecr_repository.repository.name}"
  policy     = "${data.aws_iam_policy_document.repository.json}"
}

data "aws_iam_policy_document" "repository" {
  statement {
    sid = ""

    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }
}
