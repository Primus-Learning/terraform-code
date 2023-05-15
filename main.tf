

#
#amazon linux 2023 

data "aws_ami" "amazon-2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-ebs"]
  }
  owners = ["amazon"]
}

#create ec2 instance 
resource "aws_instance" "web" {
  ami                         = data.aws_ami.amazon-2.id
  instance_type               = var.type
  key_name                    = "keypair"
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.ec2sg.id]
  subnet_id                   = aws_subnet.subnet1.id
  user_data = file("install.sh")

  tags = {
    Name = var.instanceName
    Environment = var.env
  }
}

#create security group

resource "aws_security_group" "ec2sg" {
  name        = "allow ssh an http"
  description = "allows ssh and http traffic"
  vpc_id      = aws_vpc.MyVpc.id

  ingress {
    description = "allow ssh"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "allow http traffic"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

