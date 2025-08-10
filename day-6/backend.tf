terraform {
  backend "s3" {
    bucket = "baludevops"
    key = "day-5/terraform.tfstate"
    region = "us-east-1"
    use_lockfile = true
    }
}