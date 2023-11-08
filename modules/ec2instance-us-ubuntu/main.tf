module "ec2instance-us" {
  source        = "../module-ec2"
  ami           = "ami-06dd92ecc74fdfb36"
  app_region    = "eu-central-1"
  instance_type = "t2.micro"
}

provider "aws" {
  profile = "default"
  region  = "eu-central-1"
}
