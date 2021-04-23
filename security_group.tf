resource "aws_security_group" "web-node" {
  name = "web-node"
  description = "Web Security Group"


#Incoming HTTPS Traffic allowed
  ingress {
    description      = "HTTPS from VPC"
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
    cidr_blocks = ["81.103.104.81/32", "1.1.1.1/32", "8.8.8.8/32"] # Whitelist IP address for the Incoming WebTraffic
  }

#Incoming HTTPS Traffic allowed
  ingress {
    description      = "HTTP from VPC"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


# AWS Removed the default egress rule so it needs to be stipulated
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 # Tags
  tags = {
    Name = "allow_tls"
  }
}