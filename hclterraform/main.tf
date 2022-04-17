provider "aws" {
  region  = "us-east-1"
  profile = "devops"
}

data "aws_ami" "selected_ami" {
  most_recent = true
  owners      = ["156779398815"]
  filter {
    name = "name"
    values = [
      "webapplication-${var.cloudbinary_version}",
    ]
  }
  filter {
    name   = "owner-id"
    values = ["${var.ami_aws_account_id}"]
  }
  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}


# EC2 Instance 
resource "aws_instance" "web" {
  ami                    = "data.aws_ami.selected_ami.id"
  instance_type          = "t2.micro"
  key_name               = "aws-kesav"
  subnet_id              = "subnet-ae87c8f1"
  vpc_security_group_ids = ["sg-03cb43ecdf16cd940"]
  #user_data              = file("web.sh")
  tags = {
    "Name"        = "IAC-WebServer"
    "ProjectName" = "Cloud Binary"
    "CreatedBy"   = "IaC-Terraform"
  }

}