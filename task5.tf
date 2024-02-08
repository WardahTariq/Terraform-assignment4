resource "aws_instance" "web_server_instance" {
  ami         = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.public_subnets[0].id
  key_name    = aws_key_pair.webserver_key.key_name
  user_data   = file("${path.module}/user_data1.sh")

  
  associate_public_ip_address = true  # Assign a public IP address to this EC2 instance

  tags = {
    Name = "Assignment4-EC2-1"
  }
}

resource "aws_instance" "database_instance" {
  ami         = "ami-0c7217cdde317cfec"
  instance_type = "t2.micro"
  subnet_id   = aws_subnet.private_subnets[0].id
  key_name    = aws_key_pair.webserver_key.key_name
  user_data   = file("${path.module}/user_data2.sh")

  # No need for associate_public_ip_address in private subnet

  tags = {
    Name = "Assignment4-EC2-2"
  }
}
