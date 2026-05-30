resource "aws_vpc" "my_vpc" {
  cidr_block = var.resource_values.vpc_cidr

  tags = {
    Name = var.resource_values.vpc_name
  }
}


resource "aws_subnet" "p_sub" {
  vpc_id     = aws_vpc.my_vpc.id

  count = length(var.resource_values.subnet_info.sub_cidr)

  availability_zone = var.resource_values.subnet_info.sub_az[count.index]
  cidr_block = var.resource_values.subnet_info.sub_cidr[count.index]


  tags = {
    Name = var.resource_values.subnet_info.sub_name[count.index]
  }
}




resource "aws_internet_gateway" "r_igw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "my-ingw"
  }
  
}

resource "aws_route_table" "pub_rt" {
vpc_id = aws_vpc.my_vpc.id
tags = {
  Name = "pub-rt"
}
route  {
  cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.r_igw.id
}
}




locals {
  public_subnet_indexes = [0, 2]
    private_subnet_indexes = [1, 3]

}

#    public route table creation
resource "aws_route_table_association" "pub_rt_as" {
count = length(local.public_subnet_indexes)  

subnet_id = aws_subnet.p_sub[local.public_subnet_indexes[count.index]].id
route_table_id = aws_route_table.pub_rt.id
}



#   private route table creation

resource "aws_route_table" "pvt_rt" {
vpc_id = aws_vpc.my_vpc.id
tags = {
  Name = "pvt-rt"
}

route {
  nat_gateway_id = aws_nat_gateway.r_ngtw.id
  cidr_block = "0.0.0.0/0"
}
}


# Elastic ip creation

resource "aws_eip" "eip" {
  domain = "vpc"

  tags = {
    Name = "elastic-ip"
  }
  
}

# Nat gateway creation

resource "aws_nat_gateway" "r_ngtw" {
  allocation_id = aws_eip.eip.id
  subnet_id = aws_subnet.p_sub[0].id

  tags = {
    Name = "Nat-gateway"
  }
  
}



resource "aws_route_table_association" "pvt_rt_as" {
count = length(local.private_subnet_indexes)  

subnet_id = aws_subnet.p_sub[local.private_subnet_indexes[count.index]].id
route_table_id = aws_route_table.pvt_rt.id


}
