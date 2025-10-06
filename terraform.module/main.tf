provider "aws" {
  region = var.aws_region
}

module "networking" {
  source = "../terraform.network"
}

module "database" {
  source     = "../terraform.database"
  vpc_id     = module.networking.vpc_id
  subnet_ids = [module.networking.private_subnet_id]
  db_sg_id   = module.networking.db_sg_id
}

module "backend" {
  source        = "../terraform.backend"
  subnet_id     = module.networking.public_subnet_id
  backend_sg_id = module.networking.backend_sg_id
  db_endpoint   = module.database.db_endpoint
}

module "frontend" {
  source = "../terraform.frontend"
}
