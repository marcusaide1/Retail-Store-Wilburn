terraform {
  backend "s3" {
    bucket  = "bedrock-terraform-state-YOURNAME"
    key     = "project-bedrock/terraform.tfstate"
    region  = "us-east-1"

    # Optional: replace dynamodb_table with use_lockfile for local-only locking
    use_lockfile = true
  }
}

