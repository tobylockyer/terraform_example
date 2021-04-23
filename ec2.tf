resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id # Get the ID from the lookup
  instance_type = "t3.small" # 2vCPU and 2GB Memory
  security_groups = [aws_security_group.web-node.name] # Apply the security group we made in security_group.tf
  iam_instance_profile = aws_iam_instance_profile.web_instance_profile.name # IAM instance profile that we setup
  key_name = "JumpBox" # Name of SSH Key
  user_data = file("cloudwatchagent.sh") # Script to install the cloudwatch agent

  root_block_device {
    volume_size = 15 # Requirements for 15GB of local storage  
    }
  
  tags = {
    Owner = "Toby Lockyer"
    Name = "WebServer1"
  }
}

