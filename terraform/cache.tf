resource "aws_s3_bucket" "cache_bucket" {
  bucket        = "${local.name}-cache-bucket"
  acl           = "private"
  force_destroy = true

  tags = "${merge(
    map(
      "Name", "${local.name}-cache-bucket",
      "Description", "Cache storage for ${local.name} CodeBuild project",
    ), local.tags
  )}"

  lifecycle_rule {
    id      = "codebuildcache"
    enabled = true

    prefix = "/"

    expiration {
      days = 7
    }
  }
}

resource "aws_iam_role_policy_attachment" "cache_bucket_policy_attachment" {
  policy_arn = "${aws_iam_policy.cache_bucket_policy.arn}"
  role       = "${aws_iam_role.role.id}"
}

resource "aws_iam_policy" "cache_bucket_policy" {
  name   = "${local.name}-cache-bucket-policy"
  policy = "${data.aws_iam_policy_document.cache_bucket_policy_document.json}"
}

data "aws_iam_policy_document" "cache_bucket_policy_document" {
  statement {
    sid = ""

    actions = [
      "s3:*",
    ]

    effect = "Allow"

    resources = [
      "${aws_s3_bucket.cache_bucket.arn}",
      "${aws_s3_bucket.cache_bucket.arn}/*",
    ]
  }
}
