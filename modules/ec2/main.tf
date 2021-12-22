resource "aws_instance" "webserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  tags = {
    Name = var.app_name
  }
}
