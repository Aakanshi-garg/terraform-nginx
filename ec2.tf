# key-pair
resource "aws_key_pair" "my_key" {
  key_name   = var.aws_key_pair_name
  public_key = file("terra-us-east-2.pub") # generate the public and private key using ssh-keygen
}


# vpc and security groups
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_security_group" "my_security" {
  name   = "automate-sg"
  vpc_id = aws_default_vpc.default.id #string interpolation

  #inbound rules
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
  #outbound rules
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
}

# ec2 instance
resource "aws_instance" "my_instance" {
  depends_on = [ aws_security_group.my_security , aws_key_pair.my_key ]
  key_name        = aws_key_pair.my_key.key_name
  security_groups = [aws_security_group.my_security.name]
  instance_type   = "t2.micro"
  ami             = var.instance_ami_id
  user_data       = file("install_nginx.sh")

  root_block_device {
    volume_size =  var.instance_root_volume 
    volume_type = var.root_volume_type
  }

  tags = {
    Name = "Nginx"
  }
}


