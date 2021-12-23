# ------------------------------
# EC2
# ------------------------------
resource "aws_instance" "appserver" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [var.security_group_id]
  subnet_id              = var.subnet_id
  key_name               = var.key_name

  root_block_device {
    volume_type = "gp2"
    volume_size = var.volume_size
  }

  tags = {
    Name = "${var.app_name}-${var.app_version}-${var.environment}-appserver"
  }

  user_data = <<EOF
#!/bin/bash
sudo apt -y update
sudo fallocate -l 1G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo apt -y install nginx
sudo systemctl start nginx
sudo systemctl enable nginx
EOF
}

# ------------------------------a
# Elastic IP
# ------------------------------
resource "aws_eip" "appserver" {
  instance = aws_instance.appserver.id
  vpc      = true

  tags = {
    Name = "${var.app_name}-${var.environment}-appserver"
  }
}
