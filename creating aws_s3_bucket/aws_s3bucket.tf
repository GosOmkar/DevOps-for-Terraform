resource "aws_s3_bucket" "first_bucket" {
  bucket = "gosom-dev-tera"

  tags = {
    Name        = "gosom-dev-tera"
    Environment = "Dev"
  }
}

