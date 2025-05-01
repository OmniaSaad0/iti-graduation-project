resource "aws_eip" "nat_eip" {
    domain = "vpc"
    depends_on = [ aws_internet_gateway.igw ]
    tags = {
        Name = "nat-eip"
    }
}