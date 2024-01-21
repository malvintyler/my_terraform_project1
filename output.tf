output "vpc_id" {
 value = aws_vpc.vpc_for_tera.id 
}

output "pub_sub1_id" {
  value = aws_subnet.private_sub_1.id
}

output "pub_sub2_id" {
  value = aws_subnet.public_sub_2.id
}

output "private_sub1_id" {
  value = aws_subnet.private_sub_1.id
}

output "private_sub2_id" {
  value = aws_subnet.public_sub_2.id
}