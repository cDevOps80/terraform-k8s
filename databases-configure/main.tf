
resource "aws_instance" "databases" {
  ami           = "ami-0a5c3558529277641"
  instance_type = "t3.small"
  vpc_security_group_ids = [aws_security_group.db-sg.id]
  subnet_id              = var.subnet_id
  user_data = templatefile("./user.sh",{
    MYSQL_ROOT_PASSWORD   = "RoboShop@1"
    RABBITMQ_DEFAULT_USER = "roboshop"
    RABBITMQ_DEFAULT_PASS = "roboshop123"
  })
  key_name = "nvirginia"

  instance_market_options {
    market_type = "spot"
    spot_options {
      instance_interruption_behavior = "stop"
      spot_instance_type = "persistent"
    }
  }

  tags = {
    Name = "roboshop-db"
  }
}

variable "ports" {
  default = {
    ssh = {
      port = 22
    }
    mysql = {
      port = 3306
    }
    redis = {
      port = 6379
    }
    mongod = {
      port = 27017
    }
    rabbitmq = {
      port = 5672
    }
    rabbitmq1 = {
      port = 5671
    }
  }
}

resource "aws_security_group" "db-sg" {
  name        = "allow_databases"
  description = "Allow TLS inbound traffic "
  vpc_id      = var.vpc_id

  dynamic "ingress" {
    for_each = var.ports
    iterator = ports
    content {
      from_port        = ports.value.port
      to_port          = ports.value.port
      description      = "${ports.key}-allowing"
      protocol         = "tcp"
     #security_groups  = ["sg-0665a56c7cd09a0e0"]
      cidr_blocks      = ["0.0.0.0/0"]
    }
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "roboshopdb-sg"
  }
}

/*
output "content" {
  value = templatefile("./user.sh",{
    MYSQL_ROOT_PASSWORD   = "RoboShop@1"
    RABBITMQ_DEFAULT_USER = "roboshop"
    RABBITMQ_DEFAULT_PASS = "roboshop123"
  })
}

*/

variable "vpc_id" {
  default = "vpc-07e77475583043f30"
}
variable "subnet_id" {
  default = "subnet-067a0f05c17634c96"
}