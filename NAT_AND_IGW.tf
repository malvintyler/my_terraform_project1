#crete internet gateway
resource "aws_internet_gateway" "terraform_Igateway" {
  vpc_id = aws_vpc.vpc_for_tera.id

  tags = {
    Name = "terraform_internet_gate"
  }
}



#create elastic ip
resource "aws_eip" "ngw-elasticip" {
    vpc = true
}




#create nat gateway
resource "aws_nat_gateway" "terraform_nat" {
  allocation_id = aws_eip.ngw-elasticip.id
  subnet_id     = aws_subnet.public_sub_1.id

  tags = {
   Name = "terraform_nat_gateway"
 
 
}
 depends_on = [aws_internet_gateway.terraform_Igateway] #this makes sure the internet gate way is created first

}

