resource "aws_route_table_association" "public_rta1" {
    subnet_id      = aws_subnet.public_subnet1.id
    route_table_id = aws_route_table.public_rt.id
}

resource "aws_route_table_association" "public_rta2" {
    subnet_id      = aws_subnet.public_subnet2.id
    route_table_id = aws_route_table.public_rt.id
  
}

resource "aws_route_table_association" "public_rta3" {
    subnet_id      = aws_subnet.public_subnet3.id
    route_table_id = aws_route_table.public_rt.id
  
}
resource "aws_route_table_association" "private_rta1" {
    subnet_id      = aws_subnet.private_subnet1.id
    route_table_id = aws_route_table.private_rt.id
}
resource "aws_route_table_association" "private_rta2" {
    subnet_id      = aws_subnet.private_subnet2.id
    route_table_id = aws_route_table.private_rt.id
  
}
resource "aws_route_table_association" "private_rta3" {
    subnet_id      = aws_subnet.private_subnet3.id
    route_table_id = aws_route_table.private_rt.id
  
}
