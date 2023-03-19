module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = "10.0.0.0/16"
  pubsubCIDRblock  = ["10.0.1.0/24", "10.0.2.0/24"]
  privsubCIDRblock = ["10.0.3.0/24", "10.0.4.0/24"]
  azs              = ["us-east-1a", "us-east-1b"]
}

module "database" {
  source           = "./modules/db"
  count            = 1
  db_name          = "wptfdb"
  db_engine        = "mysql"
  db_instanceclass = "db.t3.micro"
  db_pass          = "password"
  privsub_id       = module.vpc.privsub_id
  dbsecuritygroup  = module.vpc.dbsecuritygroup
}

module "loadbalancer" {
  source           = "./modules/lb"
  pubsub_id        = module.vpc.pubsub_id
  wordpress_vpc    = module.vpc.wordpress_vpc
  listenport       = 80
  listenprotocol   = "HTTP"
  albsecuritygroup = module.vpc.albsecuritygroup
  igw-wp           = module.vpc.igw-wp
  instance_id      = module.ec2.instance_id
  
}
module "ec2" {
  source           = "./modules/ec2"
  pubsub_id        = module.vpc.pubsub_id
  ec2securitygroup = module.vpc.ec2securitygroup
}

module "route53"{
	source  = "./modules/route"
	dns_name = module.loadbalancer.dns_name
	zone_id = module.loadbalancer.zone_id
}
