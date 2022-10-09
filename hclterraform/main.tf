terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }

  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

resource "aws_instance" "app_server" {
  ami                    = var.ami
  instance_type          = var.instance_type
  key_name               = "docker-keys"
  vpc_security_group_ids = ["sg-0e922c7a8c70749cf"]

  tags = {
    Name      = "app_server"
    Createdby = "IaC - Terraform"
  }
}
