resource "aws_s3_bucket" "static-website-bucket" {
  bucket = "hadiya-project-backend" # give a unique bucket name
  tags = {
    Name = "static-website-bucket"
  }
}

