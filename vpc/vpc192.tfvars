vpc_cidr = "192.168.0.0/16"
public_subnet_cidrs = [
  "192.168.1.0/24",
  "192.168.3.0/24"
]
private_subnet_cidrs = [
  "192.168.2.0/24",
  "192.168.4.0/24"
]

##Change me, this is to make a cheap deploy and don´t buy another IGW
gateway_id = "igw-xxxx"
