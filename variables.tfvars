ami_id="ami-0dc2d3e4c0f9ebd18"
instance_type="t2.micro"
tags={Name = "Public01", Enviroment = "DEV", terraform = "terraform"}
sg_name="terraform_SSH_HTTP"
ingress_rules=[
            {   from_port= 22
                to_port= 22
                protocol= "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            },{
                from_port= 80
                to_port= 80
                protocol= "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            },{
                from_port= 443
                to_port= 443
                protocol= "tcp"
                cidr_blocks = ["0.0.0.0/0"]
            }
        ]