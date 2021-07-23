provider "aws" {
    region = "us-east-1"
}

resource "aws_instance" "testIntance" {
    #The ami is a last free tier and can be obtanied when you launch a new VM
    ami = "ami-0dc2d3e4c0f9ebd18"
    associate_public_ip_address = true
    instance_type = "t2.micro"
    ##The Key Should be generate previously in the aws account
    key_name = "terraform_key"
    security_groups = ["terraform_SSH_HTTP"]
    tags = {
        Name = "Public01",
        Enviroment = "DEV"
        terraform = "terraform"
    }  
}

#Show the public IP to connect to the instance
output "instance_ip" {
  value = aws_instance.testIntance.public_ip
}
