provider "aws" {
  region = var.region
}

module "vpc" {
  source          = "../../modules/vpc"
  cidr_block      = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.101.0/24", "10.0.102.0/24"]
  azs             = ["us-east-1a", "us-east-1b"]
  enable_nat_gateway = true
  eip_allocation_ids = []
  tags = {
    Environment = "dev"
    Project     = "news-portal"
  }
  name = "news-portal-dev"
}

# eks module, rds, redis, s3, iam ইত্যাদি একইভাবে মডিউল হিসেবে যোগ করো
