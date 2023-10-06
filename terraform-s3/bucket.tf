resource "aws_s3_bucket" "robokart" {
  bucket = "robokart"
}

resource "aws_dynamodb_table" "robokart_dynamotable" {
  name           = "robokart_dynamotable"
  read_capacity  = 1
  write_capacity = 1
  hash_key       = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
