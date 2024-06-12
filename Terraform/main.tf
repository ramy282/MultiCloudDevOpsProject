provider "aws" {
  region  = var.region
}

module "vpc"{
  source = "./modules/vpc"

  vpc_cidr       = var.vpc_cidr
  vpc_name       = var.vpc_name
}

module "subnet" {

  source 		= "./modules/subnet"
  public_subnet         = var.public_subnet
  iVolve	        = module.vpc.iVolve
}

module "security-group" {
  source  = "./modules/sg"
  iVolve   = module.vpc.iVolve
  # sg-cidr = var.sg-cidr
}

module "igw" {
  source           = "./modules/igw"
  iVolve              = module.vpc.iVolve
  internet-gateway = var.internet-gateway

}

module "route-table" {
  source     = "./modules/routetable"
  iVolve        = module.vpc.iVolve
  sub_pub    = [ module.subnet.sub-pub]
  route-cidr    = var.route-cidr
  igw        = module.igw.igw
  tag 		= var.tag
}

module "instance" {
  source           = "./modules/EC2"
  sub_pub          = [ module.subnet.sub-pub]
  app_sg_id        = module.security-group.app_sg_id
  type 		   = var.type-ec2
  key-pair	   = var.key-pair
}

module "cloudwatch" {
  source = "./modules/CloudWatch"
  EC2    = module.instance.ec2_id[0]
  Email  = var.Email
  time   = var.time
}

module "s3" {
  source        = "./modules/s3"
  bucket_name   = var.bucket_name
  bucket_region = var.bucket_region
}
