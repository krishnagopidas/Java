provider "aws" {
  region = "us-east-1"
}

# S3 Bucket for Terraform State
resource "aws_s3_bucket" "tf_state" {
  bucket = "gopi-terraform-state-bucket"

  tags = {
    Name = "Terraform State Bucket"
  }
}

# DynamoDB Table for State Locking
resource "aws_dynamodb_table" "tf_lock" {
  name         = "terraform-lock"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

  tags = {
    Name = "Terraform Lock Table"
  }
}

# EC2 Instance
resource "aws_instance" "myserver" {
  ami           = "ami-0c02fb55956c7d316"
  instance_type = "t3.micro"

  tags = {
    Name = "Terraform-EC2"
  }
}
