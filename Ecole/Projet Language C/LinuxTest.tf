provider "aws" {
    region      = "us-east-1"
    access_key  = "AKIA6D2D55ANSCVHDVVZ"
    secret_key  = "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"
}

data "aws_ami" "app_ami" {
    most_recent = true
    owners = ["amazon"]
    
    filter {
        name ="name"
        values = ["amzn2-ami-hvm*"]
    }
}

resource "aws_instance" "LinuxTest" { 
    ami           = data.aws_ami.app_ami.id
    instance_type = var.instancetype
    key_name      = "devops-sikhou"
    tags = var.aws_common_tag
    security_groups = ["${aws_security_group.allow_http_https.name}"]
    root_block_device {
    delete_on_termination = true
  }
}


resource "aws_security_group" "allow_http_https" {
  name            = "Linuxsg"
  description     = "Entrant"
  
  ingress {
        description      = "TLS from VPC"
        from_port        = 443
        to_port          = 443
        protocol         = "tcp"
        cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
      description      = "http from VPC"
      from_port        = 80
      to_port          = 80
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
    }
}

resource "aws_eip" "lb" {
    instance = aws_instance.LinuxTest.id
    vpc      = true
}