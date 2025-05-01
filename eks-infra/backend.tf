# terraform {
#   backend "s3" {
#     bucket       = "terraform-stats3-bucket"
#     key          = "terraform.tfstate"
#     region       = "us-east-1"
#     use_lockfile = true
#     encrypt      = true
#   }
# }
