data "aws_ami" "ubuntu" {
  # Find the most recent ami called ubuntu
  most_recent = true

  # Filter only for ubuntu focal 20
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  
  # We only want HVM images
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  
  # We only want an image made by Canonical
  owners = ["099720109477"] # Canonical
}


