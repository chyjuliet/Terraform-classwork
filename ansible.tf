# ANSIBLE M
resource "aws_instance" "ansible-m" {
  ami           = "ami-05a36e1502605b4aa"
  instance_type = "t2.micro"
  subnet_id = aws_subnet.food-1-pub-sn.id
  key_name = "julietkey"
  vpc_security_group_ids = [aws_security_group.allow_food-1.id]
  user_data = file("install-ansible.sh")
  private_ip = "10.0.1.10"

  tags = {
    Name = "Ansible M"
  }
}