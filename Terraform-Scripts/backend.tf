terraform {
  backend "s3" {
    bucket         = "terraform-backend-bucket-mindmap"   # Replace with your S3 bucket name
    key            = "eks-demo/terraform.tfstate"     # Define a unique key within the bucket
    region         = "us-east-1"                     # Replace with your desired AWS region
    encrypt        = true                            # Enable encryption for security
    dynamodb_table = "terraform-locks"          # Replace with your DynamoDB table name
  }
}
