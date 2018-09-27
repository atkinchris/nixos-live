resource "aws_codebuild_project" "project" {
  name         = "${local.name}"
  service_role = "${aws_iam_role.role.arn}"

  artifacts {
    type     = "S3"
    location = "${aws_s3_bucket.artifact_bucket.bucket}"
  }

  cache {
    type     = "S3"
    location = "${aws_s3_bucket.cache_bucket.bucket}"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_SMALL"
    image           = "aws/codebuild/ubuntu-base:14.04"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    buildspec = "buildspec.yml"
    type      = "GITHUB"
    location  = "https://github.com/atkinchris/nixos-live"
  }

  tags = "${merge(
    map(
      "Name", "${local.name}",
      "Description", "CodeBuild project to build ${local.name}",
    ), local.tags
  )}"
}
