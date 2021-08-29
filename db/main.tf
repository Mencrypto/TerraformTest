provider "aws" {
    region = "us-east-1"
}

#create a database mysql with name example_db and public access
resource "aws_db_instance" "mysqldb" {
  allocated_storage     = 20
  max_allocated_storage = 21
  engine                = "mysql"
  engine_version        = "8.0.23"
  instance_class        = "db.t2.small"
  name                  = "exampledb"
  username              = "root"
  password              = "root1234"
  parameter_group_name  = "default.mysql8.0"
  skip_final_snapshot   = true
  publicly_accessible   = true
  vpc_security_group_ids= [aws_security_group.sg_mysql.id]
}

resource "aws_security_group" "sg_mysql"{
    name = "sg_mysqld"
    ingress {
            from_port   = 3306
            to_port     = 3306
            protocol    = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
    }
}

output "rds_hostname" {
  description = "Mysqld instance hostname"
  value       = aws_db_instance.mysqldb.address
}