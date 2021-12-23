output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "public-subnet-a_id" {
  value = aws_subnet.public-subnet-a.id
}

output "public-subnet-b_id" {
  value = aws_subnet.public-subnet-c.id
}
