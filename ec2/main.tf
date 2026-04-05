provider "aws" {
  region = "us-east-1"
}

module "web_server" {
  source        = "./modules/ec2-instance"
  instance_name = "Saireddy-Web-Server"
  instance_type = "t3.micro"
}

module "db_server" {
  source        = "./modules/ec2-instance"
  instance_name = "Saireddy-DB-Server"
  instance_type = "t3.micro" # Different size, same code!
}

# Root Output to see the IPs in your terminal
output "web_ip" {
  value = module.web_server.public_ip
}
