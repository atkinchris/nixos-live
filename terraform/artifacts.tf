resource "aws_s3_bucket" "artifact_bucket" {
  bucket        = "${local.name}-artifact-bucket"
  acl           = "private"
  force_destroy = true

  tags = "${merge(
    map(
      "Name", "${local.name}-artifact-bucket",
      "Description", "Artifact storage for ${local.name} CodeBuild project",
    ), local.tags
  )}"
}

resource "aws_iam_role_policy_attachment" "artifact_bucket_policy_attachment" {
  policy_arn = "${aws_iam_policy.artifact_bucket_policy.arn}"
  role       = "${aws_iam_role.role.id}"
}

resource "aws_iam_policy" "artifact_bucket_policy" {
  name   = "${local.name}-artifact-bucket-policy"
  policy = "${data.aws_iam_policy_document.artifact_bucket_policy_document.json}"
}

data "aws_iam_policy_document" "artifact_bucket_policy_document" {
  statement {
    sid = ""

    actions = [
      "s3:*",
    ]

    effect = "Allow"

    resources = [
      "${aws_s3_bucket.artifact_bucket.arn}",
      "${aws_s3_bucket.artifact_bucket.arn}/*",
    ]
  }
}
