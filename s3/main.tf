resource "aws_instance" "appserver" {
  ami           = "ami-06dd92ecc74fdfb36"
  instance_type = "t2.micro"
  tags = {
    Name = "new terraform ec2"
  }
}

resource "aws_s3_bucket" "app-media-store" {
  bucket = "stephan-tf-bucket"
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.app-media-store.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}
