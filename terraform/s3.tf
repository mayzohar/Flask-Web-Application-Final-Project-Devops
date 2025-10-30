resource "aws_s3_bucket" "my_s3_bucket" {
  bucket = "my-bucket-for-final-project-1"

  tags = {
    Name        = "MyApplicationForProject1"
  }
}
