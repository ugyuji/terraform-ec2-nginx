# ------------------------------
# EC2
# ------------------------------
resource "aws_instance" "appserver" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    Name = "${var.app_name}-${var.app_version}-${var.environment}-appserver"
  }
}

# ------------------------------
# Elastic IP
# ------------------------------
resource "aws_eip" "appserver" {
  instance = aws_instance.appserver.id
  vpc      = true

  tags = {
    Name = "${var.app_name}-${var.environment}-appserver"
  }
}
