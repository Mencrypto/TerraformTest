provider "aws" {
    region = "us-east-1"
}

variable "ami_id" {
    type= string
    default = "ami-0dc2d3e4c0f9ebd18"
}

variable "instance_type" {
    type= string
}

variable "tags" {
    type= map
}

variable "sg_name"{
    type= string
}

variable "ingress_rules"{
    type= list
}

variable "egress_rules"{
    type= list
}

resource "aws_security_group" "terraform_SSH_HTTP"{
    name = var.sg_name
    dynamic "ingress"{
        for_each = var.ingress_rules
        content {
            from_port= ingress.value.from_port
            to_port= ingress.value.to_port
            protocol= ingress.value.protocol
            cidr_blocks= ingress.value.cidr_blocks
        }
    }
    dynamic "egress"{
        for_each = var.egress_rules
        content {
            from_port= egress.value.from_port
            to_port= egress.value.to_port
            protocol= egress.value.protocol
            cidr_blocks= egress.value.cidr_blocks
        }
    }
}

resource "aws_instance" "testIntance" {
    #The ami is a last free tier and can be obtanied when you launch a new VM
    ami = var.ami_id
    associate_public_ip_address = true
    instance_type = var.instance_type
    ##The Key Should be generate previously in the aws account
    key_name = "terraform_key"
    security_groups = [aws_security_group.terraform_SSH_HTTP.name]
    tags = var.tags
    #Use a provisioner to install docker and run a nginx container
    provisioner "remote-exec" {
      connection {
        type = "ssh"
        user = "ec2-user"
        private_key = file("~/terraform_key.pem")
        host = self.public_ip
      }
      inline = ["sudo yum install docker -y", "sudo systemctl start docker", "sudo docker run -d -p 80:80 nginx"]
    }
}

#Show the public IP to connect to the instance
output "instance_ip" {
  value = aws_instance.testIntance.public_ip
}
