# Remote backend
// terraform {
//   backend "s3" {
//     bucket = "bastion-tfstate-backend"
//     key    = "env:/dev/bastion.tfstate"
//     region = "us-east-1"
//     dynamodb_table = "bastion-terraform-state-locking"
//     encrypt = true
//   }
// }

# Creating bucket for tfstate
resource "aws_s3_bucket" "bucket" {
  bucket = "bastion-tfstate-backend"
  versioning {
    enabled = true
  }
  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  lifecycle {
    prevent_destroy = true
  }
  tags = {
    Name = "S3 Remote tfstate"
  }
}

# Creating Dynamodf for locking
resource "aws_dynamodb_table" "terraform_lock" {
  name           = "bastion-terraform-state-locking"
  read_capacity  = 5
  write_capacity = 5
  hash_key       = "LockID"
  attribute {
    name = "LockID"
    type = "S"
  }
  tags = {
    "Name" = "DynamoDB tfstate Lock Table"
  }
}
