provider "aws" {
  region  = "us-east-1"
  alias   = "main"
  access_key = var.access_key
  secret_key = var.secret_key
}

provider "aws" {
  region  = "us-east-2"
  alias   = "secondary"
  access_key = var.access_key
  secret_key = var.secret_key
}

# BACKEND QUE SOPORTA LA INFRAESTRUCTURA A DESPLEGAR
terraform {
  backend "s3" {
    encrypt = true    
    bucket = "liderapp-tf-state"
    dynamodb_table = "liderapp-tf-state"
    key    = "full_architecture_poc_liderapp/terraform.tfstate"
    region = "us-east-1"
  }
}

## REFERENCIA AL BACKEND
module "backend" {

  providers = {
    aws = aws.main
  }
  source = "./modules/TF State"
}

# module "simple_ecr" {
#   providers = {
#     aws = aws.secondary
#   }
#   source = "./modules/ecr"
#   env            = var.env
#   tags           = var.tags
#   functionality  = var.functionality
#   force_delete   = var.force_delete

# }

module "ecs_cluster"{
  providers = {
    aws = aws.secondary
  }
  source = "./modules/ecs_cluster"
  env            = var.env
  functionality = var.functionality
  ecs_cluster_name = var.ecs_cluster_name
  alb-name = var.alb-name
  task-execution-role-name = var.task-execution-role-name
  vpc_id = module.vpc.vpc
  availability_zones = var.availability_zones
  subnets = [module.vpc.public_subnet_1a,module.vpc.public_subnet_1b]

}

module "vpc"{
  providers = {
    aws = aws.secondary
  }
  source = "./modules/vpc"
  env            = var.env
  functionality = var.functionality
  availability_zones = var.availability_zones
  cidr_block = var.cidr_block

}

# module "s3_static_page"{
#   providers = {
#     aws = aws.secondary
#   }
#   source = "./modules/S3_static_page"
#   env = var.env
#   functionality = var.functionality
#   bucket_name = var.bucket_name
#   oac-name = var.oac-name
# }

# module "aurora_cluster"{
#   providers = {
#     aws = aws.secondary
#   }
#   source = "./modules/aurora"
#   env = var.env
#   functionality = var.functionality
#   cluster_name = var.cluster_name
#   rds_sg_name = var.rds_sg_name
#   vpc_id = module.vpc.vpc
#   instance_name = var.instance_name
#   cluster_engine = var.cluster_engine
#   instance_class = var.instance_class
#   subnets = [module.vpc.private_subnet_1a, module.vpc.private_subnet_1b]
#   db_username = var.db_username
#   db_password = var.db_password
#   db_name = var.db_name
#   }

# module "api_gw"{
#   providers = {
#     aws = aws.secondary
#   }
#   source = "./modules/API-gw"
#   env = var.env
#   functionality = var.functionality
#   post_item_lambda = module.lambdas.post_item_lambda
#   get_item_lambda = module.lambdas.get_item_lambda
# }

# module "lambdas"{
#   providers = {
#     aws = aws.secondary
#   }
#   source = "./modules/Lambdas"
#   items_execution_arn = module.api_gw.items_execution_arn
# }

##TEST DE EJECUCIÓN
######
###
###