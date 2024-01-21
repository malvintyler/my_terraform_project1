#CREATE SECURITY GROUP
resource "aws_security_group" "ALB_SG" {
  name        =var.alb_sg_name
  description = var.alb_sg_discription
  vpc_id      = aws_vpc.vpc_for_tera.id

  #make sure the vpc is creted first
  depends_on = [aws_vpc.vpc_for_tera]
  
  #inbound rule
  #http acess from anywhere
  ingress {
    description = "Allow HTTP Traffic"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = "tcp"
    cidr_blocks = var.alb_sg_ingress_cidr_blocks
  }

  #ssh from anywher
  ingress {
    description = "Allow SSH Traffic"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = "tcp"
    cidr_blocks = var.alb_sg_ingress_cidr_blocks
  }

  #outbpund rule
  egress {
    from_port   = "0"
    to_port     = "0"
    protocol    = "-1"
    cidr_blocks = var.alb_sg_egress_cidr_blocks
  }
 
  tags = {
    Name = "ALB SG"
  }
}

# Creating Security Group for ASG Launch Template
resource "aws_security_group" "launch_tem-sg" {
  name   = var.launch_t_sg_name
  vpc_id = aws_vpc.vpc_for_tera.id

  # Inbound Rules
  # HTTP access from anywhere
  ingress {
    from_port       = var.http_port
    to_port         = var.http_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ALB_SG.id]
  }

  # SSH access from anywhere
  ingress {
    from_port       = var.ssh_port
    to_port         = var.ssh_port
    protocol        = "tcp"
    security_groups = [aws_security_group.ALB_SG.id]
  }

  # Outbound Rules
  # Internet access to anywhere
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = var.launch_t_sg_egress_cidr_blocks
  }
}