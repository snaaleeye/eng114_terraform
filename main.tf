# launch a server on aws

# who is the cloud provider AWS
provider "aws" {

# where do you ant to create resources eu-west-1
  region = "eu-west-1"

}

# what type of server - ubuntu 18.04 LTS ami
resource "aws_instance" "app_instance" {


#size of the server t2-micro
  ami = "ami-0b47105e3d7fc023e"
  instance_type = "t2.micro"
  key_name= "eng114_sharmake.pem"
# do we need it to have a public access
  associate_public_ip_address = true


# what do we want to name it
  tags = {
      Name = "eng114_sharmake_terraform_app"
 }
}

