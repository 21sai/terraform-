resource "aws_vpc" "terraformvpc" {
  cidr_block = "10.0.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "terraformvpc"
  }
   
}
/*creation of subnet0 */ 
resource "aws_subnet" "tpublic1" { 
  vpc_id = aws_vpc.terraformvpc.id 
  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
  tags = {
    Name = "tpublic1"
  }
   
}
# creation of public subnet1
resource "aws_subnet" "tpublic2" {
  vpc_id = aws_vpc.terraformvpc.id
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone = "ap-south-1b"
  tags = {
    Name = "tpublic2"
  }
  
}
#creation of private subnet
resource "aws_subnet" "tprivate1" {
  vpc_id = aws_vpc.terraformvpc.id
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availibility_zone = "ap-south-1a"
  tags = {
    Name = "tprivate1"
  }
  
}
#Internet gate way
resource "aws_internet_gateway" "tinternetgateway" {
  vpc_id = aws_vpc.terraformvpc.id

  tags = {
    Name = "tinternetgateway"
  }
  
}
# route table
resource "aws_route_table" "t-routable-p" {
  vpc_id = aws_vpc.terraformvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.tinternetgateway.id
  }
  tags = {
    Name = "t-routable-p"
  }

}
# route table associations
resource "aws_route_table_association" "tpublic1" {
  subnet_id = aws_subnet.tpublic1.id
  route_table_id = aws_route_table.t-routable-p.id

}
resource "aws_route_table_association" "tpublic2" {
  subnet_id = aws_subnet.tpublic2.id
  route_table_id = aws_route_table.t-routable-p.id
  
}


