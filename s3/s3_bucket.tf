resource "aws_s3_bucket" "dummyProject-bucket" {
  bucket = "dummy-project-bucket"
  acl    = "private"
  region = "us-west-2"

  versioning {
    enabled = true
  }

  logging {
    target_bucket = "${var.log_bucket}"
    target_prefix = "dummyProject-log/"
  }

  //Apply these rules only to files in dev folders
  lifecycle_rule {
    id      = "dummy-dev"
    prefix  = "dev/"
    enabled = true

    transition {
      days          = 90
      storage_class = "GLACIER"
    }

    //delete dev files after 1 year
    expiration {
      days = 365
    }
  }

  //Apply these rules only to files in prod folders
  lifecycle_rule {
    id      = "dummy-prod"
    prefix  = "prod/"
    enabled = true

    transition {
      days          = 90
      storage_class = "STANDARD_IA"
    }

    transition {
      days          = 180
      storage_class = "GLACIER"
    }
  }

  //Grant cross-account access to customer team
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "AWS": [
          "${var.customer_team_emr_role}",
          "${var.customer_team_datapipeline_resource_role}",
          "${var.customer_team_root}"
        ]
      },
      "Action": [
        "s3:List*",
        "s3:Put*",
        "s3:Get*"
      ],
      "Resource": [
        "arn:aws:s3:::dummy-project-bucket",
        "arn:aws:s3:::dummy-project-bucket/*"
      ]
    }
  ]
}
POLICY

  tags {
    Team                    = "${var.team}"
    Owner                   = "${var.owner}"
    Product                 = "${var.product}"
    CustomRootPrefixCleanup = "false"
  }
}
