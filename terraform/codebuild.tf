resource "aws_codebuild_project" "project" {
  name         = "${local.name}"
  service_role = "${aws_iam_role.role.arn}"

  artifacts {
    type     = "S3"
    location = "${aws_s3_bucket.artifact_bucket.bucket}"
  }

  cache {
    type = "NO_CACHE"
  }

  environment {
    compute_type    = "BUILD_GENERAL1_LARGE"
    image           = "${aws_ecr_repository.repository.repository_url}:latest"
    type            = "LINUX_CONTAINER"
    privileged_mode = true
  }

  source {
    buildspec       = "buildspec.yml"
    type            = "GITHUB"
    location        = "https://github.com/atkinchris/nixos-live.git"
    git_clone_depth = 1
  }

  tags = "${merge(
    map(
      "Name", "${local.name}",
      "Description", "CodeBuild project to build ${local.name}",
    ), local.tags
  )}"
}
