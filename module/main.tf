terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0.0"
    }
  }
}

provider "aws" {
  region  = "us-east-1"
  profile = "default"
}

resource "aws_ecr_repository" "test" {
  name = "test"
}

data "aws_iam_policy_document" "test" {
  statement {
    sid    = "new policy"
    effect = "Allow"
    
    principals {
      type        = "AWS"
      identifiers = ["example"]
    }
    
    actions = [
      "ecr:GetDownloadUrlForLayer",
      "ecr:BatchGetImage",
      "ecr:BatchCheckLayerAvailability",
      "ecr:PutImage",
      "ecr:InitiateLayerUpload",
      "ecr:UploadLayerPart",
      "ecr:CompleteLayerUpload",
      "ecr:DescribeRepositories",
      "ecr:GetRepositoryPolicy",
      "ecr:ListImages",
      "ecr:DeleteRepository",
      "ecr:BatchDeleteImage",
      "ecr:SetRepositoryPolicy",
      "ecr:DeleteRepositoryPolicy",
    ]
  }
}

resource "aws_ecr_repository_policy" "test" {
  repository = aws_ecr_repository.test.name
  policy     = data.aws_iam_policy_document.test.json
}

resource "aws_ecr_repository" "test2" {
  name = "test2"
}

resource "aws_ecr_repository_policy" "test2" {
  repository = aws_ecr_repository.test2
    # policy     = data.aws_iam_policy_document.test2.json
}

