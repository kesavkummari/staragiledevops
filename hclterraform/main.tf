provider "aws" {
  region  = "us-east-1"
  profile = "devops"
}

# EC2 Instance 

resource "aws_instance" "web" {
  ami                    = "ami-0e400db9332cffb63"
  instance_type          = "t2.micro"
  key_name               = "aws-kesav"
  subnet_id              = "subnet-ae87c8f1"
  vpc_security_group_ids = ["sg-03cb43ecdf16cd940"]
  user_data              = file("web.sh")
  tags = {
    "Name"        = "IAC-WebServer"
    "ProjectName" = "Cloud Binary"
    "CreatedBy"   = "IaC-Terraform"
  }

}