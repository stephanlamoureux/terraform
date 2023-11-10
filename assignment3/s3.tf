# Create role for EC2 to access S3 Buckets.
resource "aws_iam_role" "ec2_s3_access_role" {
  name = var.iam_role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com"
        }
      },
    ]
  })
}

# Create an IAM policy that grants access to the S3 bucket.
resource "aws_iam_policy" "s3_access_policy" {
  name        = var.iam_policy_name
  description = "Policy to access specific S3 bucket"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
          "s3:ListBucket"
        ],
        Effect = "Allow",
        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}",
          "arn:aws:s3:::${var.s3_bucket_name}/*"
        ]
      },
    ]
  })
}

# Attach the S3AccessPolicy to the IAM role.
resource "aws_iam_role_policy_attachment" "s3_access_attach" {
  role       = aws_iam_role.ec2_s3_access_role.name
  policy_arn = aws_iam_policy.s3_access_policy.arn
}

# Define an IAM instance profile to associate this role with the EC2 instance.
resource "aws_iam_instance_profile" "ec2_s3_profile" {
  name = var.iam_instance_profile_name
  role = aws_iam_role.ec2_s3_access_role.name
}

# Create a new S3 Bucket.
resource "aws_s3_bucket" "my_bucket" {
  bucket = var.s3_bucket_name
}
