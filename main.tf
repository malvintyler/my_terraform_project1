#create vpc
resource "aws_vpc" "vpc_for_tera" {
  cidr_block       = var.vpc_cidr
  instance_tenancy = "default"

  tags = {
    Name = "terravpc"
  }
}

#create first pub subnet
resource "aws_subnet" "public_sub_1" {
  vpc_id     = aws_vpc.vpc_for_tera.id
  cidr_block = var.pub_cidr1
  availability_zone =var.availability_zone-1
  map_public_ip_on_launch =true

  tags = {
    Name = var.pubsub1_name
  }
}

#create second pub subnet
resource "aws_subnet" "public_sub_2" {
  vpc_id     = aws_vpc.vpc_for_tera.id
  cidr_block = var.pub_cidr2
  availability_zone =var.availability_zone-2
  map_public_ip_on_launch =true

  tags = {
    Name = var.pubsub2_name
  }
}

#create first private subnet
resource "aws_subnet" "private_sub_1" {
  vpc_id     = aws_vpc.vpc_for_tera.id
  cidr_block = var.private_cidr1
  availability_zone =var.availability_zone-1
  map_public_ip_on_launch =true

  tags = {
    Name = var.private_sub_name1
  }
}

#create second private subnet
resource "aws_subnet" "private_sub_2" {
  vpc_id     = aws_vpc.vpc_for_tera.id
  cidr_block = var.private_cidr2
  availability_zone =var.availability_zone-2
  map_public_ip_on_launch =true

  tags = {
    Name = var.private_sub_name2
  }
}


#create public route table
resource "aws_route_table" "public_route" {
  vpc_id = aws_vpc.vpc_for_tera.id

  route {
    cidr_block = var.public_rt_cidr
    gateway_id = aws_internet_gateway.terraform_Igateway.id
  }

  tags = {
    Name = "Pub_route"
  }
}

#create private route table
resource "aws_route_table" "private_route" {
  vpc_id = aws_vpc.vpc_for_tera.id

  route {
    cidr_block = var.private_rt_cidr
    gateway_id = aws_nat_gateway.terraform_nat.id
  }

  
  tags = {
    Name = "private_route"
  }
}

#associate public route with pulic subnet1

resource "aws_route_table_association" "pub_sub_rt_as1" {
  subnet_id      = aws_subnet.public_sub_1.id
  route_table_id = aws_route_table.public_route.id
}

#associate public route with pulic subnet2
resource "aws_route_table_association" "pub_sub_rt_as2" {
  subnet_id      = aws_subnet.public_sub_2.id
  route_table_id = aws_route_table.public_route.id
}

#associate private route table to private subnet 1
resource "aws_route_table_association" "private_subnet_ass1" {
  subnet_id      = aws_subnet.private_sub_1.id
  route_table_id = aws_route_table.private_route.id


  #wait for private route table to be created first before assocaition
  depends_on=[aws_route_table.private_route]

}

#associate private route table to private subnet 2
resource "aws_route_table_association" "private_subnet_ass2" {
  subnet_id      = aws_subnet.private_sub_2.id
  route_table_id = aws_route_table.private_route.id

  #wait for private route table to be created first before assocaition
  depends_on=[aws_route_table.private_route]

}

#create keypair
