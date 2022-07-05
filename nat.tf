# define exteral ip - nat gateway use for ec2 or rds in private
# to connect secure over internet.
resource "aws_eip" "t-natgate" {
  vpc = true  
}

resource "aws_nat_gateway" "tnatgateway" {
  allocation_id = aws_eip.t-natgate.id
  subnet_id = aws_subnet.tpublic1.id
  depends_on = [aws_internet_gateway.tinternetgateway]
  
}

resource "aws_route_table" "troute-private" {
  vpc_id = aws_vpc.terraformvpc.id

  route  {
    cidr_block = "0.0.0.0/0"
    nat_gateway_id = aws_nat_gateway.tnatgateway.id
  }  
  tags = {
    Name = "troute-private"
  }
  
}
#routetable association with private
resource "aws_route_table_association" "tprivate" {
  subnet_id = aws_subnet.tprivate1.id
  route_table_id = aws_route_table.troute-private.id
}