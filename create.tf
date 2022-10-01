terraform {
    required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
  access_key = "${var.access}"
  secret_key = "${var.secret}"
}

module "vpc" {
  source             = "terraform-aws-modules/vpc/aws"
  version            = "2.21.0"
  name               = var.vpc_name
  cidr               = var.vpc_cidr
  azs                = var.vpc_azs
  private_subnets    = var.vpc_private_subnets
  public_subnets     = var.vpc_public_subnets
  enable_nat_gateway = var.vpc_enable_nat_gateway
  tags               = var.vpc_tags
}

module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  for_each = toset(["PVS1", "PVS2", "PVS3"])

  name = "Servidor-${each.key}"

  ami                    = "ami-08c40ec9ead489470"
  instance_type          = "t2.micro"
  monitoring             = true
  key_name               = "pvs"
  vpc_security_group_ids = [module.vpc.default_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
