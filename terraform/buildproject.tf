resource "aws_codebuild_project" "test" {
  name           = "test"
  description    = "This project tests and published the applications docker image"
  service_role = aws_iam_role.build_project_role.arn

  artifacts {
    type = "CODEPIPELINE"
  }

  cache {
    type  = "LOCAL"
    modes = ["LOCAL_DOCKER_LAYER_CACHE"]
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:4.0"
    type                        = "LINUX_CONTAINER"
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = "terraform/buildspec-plan.yml"
  }
}

resource "aws_iam_role" "build_project_role" {
  name               = "build_project_role"
  assume_role_policy = data.aws_iam_policy_document.build_project_assume_role.json
}

resource "aws_iam_role_policy" "build_project_policy" {
  name   = "build_project_policy"
  role   = aws_iam_role.build_project_role.name
  policy = data.aws_iam_policy_document.build_project_policy_document.json
}

data "aws_iam_policy_document" "build_project_assume_role" {
  statement {
    effect = "Allow"

    principals {
      type        = "Service"
      identifiers = ["codebuild.amazonaws.com"]
    }

    actions = ["sts:AssumeRole"]
  }
}


data "aws_iam_policy_document" "build_project_policy_document" {
  statement {
    effect = "Allow"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]

    resources = ["*"]
  }

  statement {
    effect = "Allow"
    sid = "SSOCodebuildAllow"

    actions = [
      "s3:*",
      "kms:*",
      "ssm:*",
      "autoscaling:StartInstanceRefresh",
      "autoscaling:Describe*",
      "autoscaling:UpdateAutoScalingGroup",
      "ec2:AttachVolume",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:CopyImage",
      "ec2:CreateImage",
      "ec2:CreateKeyPair",
      "ec2:CreateSecurityGroup",
      "ec2:CreateSnapshot",
      "ec2:CreateTags",
      "ec2:CreateVolume",
      "ec2:CreateLaunchTemplateVersion",
      "ec2:DeleteKeyPair",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSnapshot",
      "ec2:DeleteVolume",
      "ec2:DeregisterImage",
      "ec2:DescribeImageAttribute",
      "ec2:DescribeImages",
      "ec2:DescribeInstances",
      "ec2:DescribeInstanceStatus",
      "ec2:DescribeRegions",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeSnapshots",
      "ec2:DescribeSubnets",
      "ec2:DescribeTags",
      "ec2:DescribeVolumes",
      "ec2:DetachVolume",
      "ec2:GetPasswordData",
      "ec2:ModifyImageAttribute",
      "ec2:ModifyInstanceAttribute",
      "ec2:ModifySnapshotAttribute",
      "ec2:RegisterImage",
      "ec2:RunInstances",
      "ec2:StopInstances",
      "ec2:TerminateInstances"
    ]
    resources = ["*"]
  }
}
