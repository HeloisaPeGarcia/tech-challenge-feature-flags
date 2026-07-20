terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  # Configuração de Backend Remoto S3
  # Opcional: Adicione a flag 'use_lockfile = true' se estiver usando o Terraform 1.10+
  # Caso contrário, utilize uma tabela DynamoDB para State Locking (ex: tflock-table)
  backend "s3" {
    bucket         = "tech-challenge-tfstate-bucket"
    key            = "dev/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-lock-table" # Para travar o estado e evitar concorrência
  }
}

provider "aws" {
  region = var.aws_region
}
