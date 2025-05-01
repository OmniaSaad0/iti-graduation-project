
resource "aws_subnet" "public_subnet1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public_subnets[0]
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-1"
    } 
}

resource "aws_subnet" "public_subnet2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public_subnets[1]
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-2"
    }  
}

resource "aws_subnet" "public_subnet3" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.public_subnets[2]
    availability_zone = "${var.region}c"
    map_public_ip_on_launch = true
    tags = {
        Name = "public-subnet-3"
    }  
}
resource "aws_subnet" "private_subnet1" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.private_subnets[0]
    availability_zone = "${var.region}a"
    map_public_ip_on_launch = false
    tags = {
        Name = "private-subnet-1"
    }  
}
resource "aws_subnet" "private_subnet2" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.private_subnets[1]
    availability_zone = "${var.region}b"
    map_public_ip_on_launch = false
    tags = {
        Name = "private-subnet-2"
    }  
}
resource "aws_subnet" "private_subnet3" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block = var.private_subnets[2]
    availability_zone = "${var.region}c"
    map_public_ip_on_launch = false
    tags = {
        Name = "private-subnet-3"
    }  
}





