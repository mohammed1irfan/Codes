resource "aws_s3_bucket_acl" "hadiya-project-backend" {
    bucket = aws_s3_bucket.static-website-bucket.id
    acl    = "public-read"
    depends_on = [aws_s3_bucket_ownership_controls.s3_bucket_acl_ownership]
}

resource "aws_s3_bucket_ownership_controls" "s3_bucket_acl_ownership" {
  bucket = aws_s3_bucket.static-website-bucket.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
  depends_on = [aws_s3_bucket_public_access_block.example]
}

resource "aws_iam_user" "hadiya-project-backend" {
  name = "hadiya-project-backend"
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.static-website-bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "hadiya-project-backend" {
    bucket = aws_s3_bucket.static-website-bucket.id
    policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Principal = "*"
        Action = [
          "s3:*",
        ]
        Effect = "Allow"
        Resource = [
          "arn:aws:s3:::hadiya-project-backend",
          "arn:aws:s3:::hadiya-project-backend/*"
        ]
      },
      {
        Sid = "PublicReadGetObject"
        Principal = "*"
        Action = [
          "s3:GetObject",
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::hadiya-project-backend",
          "arn:aws:s3:::hadiya-project-backend/*"
        ]
      },
    ]
  })
   depends_on = [aws_s3_bucket_public_access_block.example]
  }
