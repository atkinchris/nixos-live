resource "aws_iam_role" "role" {
  name               = "${local.name}-role"
  assume_role_policy = "${data.aws_iam_policy_document.assume_role_policy.json}"
}

data "aws_iam_policy_document" "assume_role_policy" {
  statement {
    sid = ""

    actions = [
      "sts:AssumeRole",
    ]

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    effect = "Allow"
  }
}

resource "aws_iam_role_policy_attachment" "ecr_policy_attachment" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = "${aws_iam_role.role.id}"
}

resource "aws_iam_role_policy_attachment" "role_policy_attachment" {
  policy_arn = "${aws_iam_policy.role_policy.arn}"
  role       = "${aws_iam_role.role.id}"
}

resource "aws_iam_policy" "role_policy" {
  name   = "${local.name}-role-policy"
  policy = "${data.aws_iam_policy_document.role_permissions.json}"
}

data "aws_iam_policy_document" "role_permissions" {
  statement {
    sid = ""

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    effect = "Allow"

    resources = [
      "*",
    ]
  }
}
