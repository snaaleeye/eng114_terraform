# launch a server on ec2

# who is the cloud provider
provider "aws"{

# where do you want to create the resources (eu-west-1)
  region = "eu-west-1"
}

# Create VPC
resource "aws_vpc" "eng114_sharmake_terraform" {
  cidr_block = "10.47.0.0/16" 
  instance_tenancy = "default"

  tags = {
    Name = "eng114_sharmake_terraform_vpc"
  }
}

# Create Internet Gateway
resource "aws_internet_gateway" "eng114_sharmake_terraform_ig" {
  vpc_id = aws_vpc.eng114_sharmake_terraform.id
  tags = {
    Name = "eng114_sharmake_terraform-ig"
  }
}

# Create Public Subnet (for app)
resource "aws_subnet" "eng114_sharmake_terraform_public_subnet" {
  vpc_id = aws_vpc.eng114_sharmake_terraform.id
  cidr_block = "10.47.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
  
  tags = {
    Name = "eng114_sharmake_terraform_public_subnet"
  }
}

# Create Private Subnet (for db)
resource "aws_subnet" "eng114_sharmake_terraform_private_subnet" {
  vpc_id = aws_vpc.eng114_sharmake_terraform.id
  cidr_block = "10.47.10.0/24"
  map_public_ip_on_launch = true
  availability_zone = "eu-west-1b"
  
  tags = {
    Name = "eng114_sharmake_terraform_private_subnet"
  }
}

# Route table (public)
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.eng114_sharmake_terraform.id

  tags = {
    Name = "eng114_sharmake_terraform_public_RT"
  }
}

# Route from (public)
resource "aws_route" "eng114_sharmake_terraform_public_internet_gateway" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.eng114_sharmake_terraform_ig.id
}


# Subnet assosiations (public)
resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.eng114_sharmake_terraform_public_subnet.id
  route_table_id = aws_route_table.public.id
}


# Create app instance 
resource "aws_instance" "app_instance" {
  ami = "ami-0b47105e3d7fc023e"
  instance_type = "t2.micro"
  key_name = "eng114_sharmake"
  subnet_id = aws_subnet.eng114_sharmake_terraform_public_subnet.id
  vpc_security_group_ids = ["${aws_security_group.eng114_sharmake_terraform_app_sg.id}"]

 associate_public_ip_address = true

 tags = {
    Name = "eng114_sharmake_terraform_app"
 }
}

# Create db instance

resource "aws_instance" "db_instance" {
  ami = "ami-0a5bbd811afddc5f1"
  instance_type = "t2.micro"
  key_name = "eng114_sharmake"

  subnet_id = aws_subnet.eng114_sharmake_terraform_private_subnet.id
  vpc_security_group_ids = ["${aws_security_group.eng114_sharmake_terraform_db_sg.id}"]


 associate_public_ip_address = false

 tags = {
    Name = "eng114_sharmake_terraform_db"
 }
}


# Create controller instance

resource "aws_instance" "controller_instance" {
  ami = "a"
  instance_type = "t2.micro"
  key_name = "eng114_sharmake"

  subnet_id = aws_subnet.eng114_sharmake_terraform_public_subnet.id
  vpc_security_group_ids = ["${aws_security_group.eng114_sharmake_terraform_app_sg.id}"]


 associate_public_ip_address = true

 tags = {
    Name = "eng114_sharmake_terraform_controller"
 }
}

resource "aws_security_group" "eng114_sharmake_terraform_app_sg" {
  name        = "eng114_sharmake_terraform_app_sg"
  vpc_id = aws_vpc.eng114_sharmake_terraform.id

  ingress {
    description      = "app"
    from_port        = 3000
    to_port          = 3000
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "ssh public access"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    description      = "Not secure"
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1" # allow all
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  ingress {
    from_port = 80
    protocol  = "tcp"
    to_port   = 80
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port = 0
    protocol  = "-1"
    to_port   = 0
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "eng114_sharmake_terraform_app_sg"
  }
}

resource "aws_security_group" "eng114_sharmake_terraform_db_sg"{
	name = "eng114_sharmake_terraform_db_sg"
	description = "27017 for mongoDB"
	vpc_id = aws_vpc.eng114_sharmake_terraform.id

	ingress {
		description = "27017 from app instance"
		from_port = 27017
		to_port = 27017
		protocol = "tcp"
	}

## remove in productions
	ingress {
		description = "SSH from localhost"
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]	
  }


	egress {
		description = "All traffic out"
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}

  tags = {
    Name = "eng114_sharmake_terraform_db_sg"
  }

}

