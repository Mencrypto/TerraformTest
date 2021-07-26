ami_id="ami-09e67e426f25ce0d7"
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

egress_rules=[
            {   from_port= 0
                to_port= 0
                protocol= "-1"
                cidr_blocks = ["0.0.0.0/0"]
            }
        ]