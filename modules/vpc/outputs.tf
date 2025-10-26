output "vpc_name" {
  value = aws_vpc.main.tags["Name"]
}

output "vpc_id" {
  value = aws_vpc.main.id
}

output "subnet_cidr" {
  value = aws_subnet.public.cidr_block
}