output "my_vpc" {
  value = aws_vpc.my-vpc.id
}

output "public_subnet1" {
  value = aws_subnet.public_subnet1.id
}

output "public_subnet2" {
  value = aws_subnet.public_subnet2.id
}

output "public_subnet3" {
  value = aws_subnet.public_subnet3.id
  
}

output "private_subnet1" {
  value = aws_subnet.private_subnet1.id
}
output "private_subnet2" {
  value = aws_subnet.private_subnet2.id
}
output "private_subnet3" {
  value = aws_subnet.private_subnet3.id
}