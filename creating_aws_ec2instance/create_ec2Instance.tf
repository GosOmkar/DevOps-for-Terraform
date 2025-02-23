## CREATING KEY PAIR ####

resource "aws_key_pair" "my-key" {
    key_name   = "terraec2-key"
    public_key = file("terrademo-key.pub")
}

### CREATING Vpc ###

resource "aws_default_vpc" "default" {
  tags = {
    name = "Default vpc"
  }
}


### CREATING SECURITY GROUP ###

resource "aws_security_group" "my_security_gp" {
    name        = "my extra x+ security"
    description = "This is a special SG created by me"
    vpc_id      = aws_default_vpc.default.id   #interpolation

    ###  Inbound rules  (use block format)
    ingress {
        description = "Allow SSH"
        from_port   = 22
        to_port     = 22
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ###  Inbound rules  (use block format) 
    ingress {
        description = "Allow HTTP"
        from_port   = 80
        to_port     = 80
        protocol    = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    # Outbound rules egress rule (use block format)
    egress {
        description = "Allow all outgoing traffic"
        from_port   = 0
        to_port     = 0
        protocol    = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}



resource "aws_instance" "my_instance" {
    instance_type   = "t2.micro"
    ami            = "ami-03fd334507439f4d1"
    key_name       = aws_key_pair.my-key.key_name  #interpolation
    security_groups = [aws_security_group.my_security_gp.name] #interpolation 
 
    root_block_device {
      volume_size = 8
      volume_type = "gp3"
    }

    tags = {
      Name = "tera-ec2-server"
    }
}

