terraform {
  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "fabioaraujo"

    workspaces {
      prefix = "NS"
    }
  }
}

provider "aws" {}

resource "aws_s3_bucket" "bucket" {
  bucket = var.bucket-name
  acl    = "public-read"
  policy = <<EOF
{
  "Version":"2012-10-17",
  "Statement":[{
	"Sid":"PublicReadGetObject",
        "Effect":"Allow",
	  "Principal": "*",
      "Action":["s3:GetObject"],
      "Resource":["arn:aws:s3:::${var.bucket-name}/*"
      ]
    }
  ]
}
EOF

  website {
    index_document = "index.html"
    error_document = "error.html"
  }

  tags = {
    Terraform   = "true"
    Environment = var.environment
    env         = var.environment
  }
}
