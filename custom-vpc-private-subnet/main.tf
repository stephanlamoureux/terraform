resource "aws_instance" "assignment4" {
  instance_type          = var.instance_type
  ami                    = var.ami
  key_name               = var.key_name
  vpc_security_group_ids = [aws_security_group.my_security_group.id]
  user_data              = file("${path.module}/user_data.sh")
  subnet_id              = aws_subnet.public_subnet.id
  tags = {
    Name = "TFAssignment4"
  }
}
