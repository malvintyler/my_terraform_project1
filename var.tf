variable "vpc_cidr" {
  type = string
}

variable "pub_cidr1" {
    type = string
  
}


variable "availability_zone-1" {
  type = string
  default = "us-east-1a"
}


variable "pubsub1_name" {
    type = string
    default = "public_subnet_1"
  
}


variable "pub_cidr2" {
  type = string
  
}
variable "availability_zone-2" {
  type = string
  default = "us-east-1b"
}


variable "pubsub2_name" {
  type = string
  default = "public_subnet_2"
}

variable "private_cidr1" {
  type = string
}

variable "private_sub_name1" {
  type = string
  default = "private_subnet_1"

}

variable "private_cidr2" {
  type = string
}

variable "private_sub_name2" {
  type = string
  default = "private_subnet_2"
}

variable "public_rt_cidr" {
  type = string
}

variable "private_rt_cidr" {
  type = string
}

variable "ssh_port" {
  type        = number
  description = "Port for SSH traffic"
  default     = 22

}

variable "http_port" {
  type        = number
  description = "Port for HTTP traffic"
  default     = 80
}

variable "alb_sg_name" {
  type        = string
  description = "Name of the App Load Balancer security group"
  default     = "alb-s"
}

variable "alb_sg_discription" {
  type        = string
  description = "Description of the App Load Balancer security group"
  default     = "Security Group for the App Load Balancer"
}

variable "alb_sg_ingress_cidr_blocks" {
   type        = list(string)
  description = "List of CIDR blocks to allow inbound traffic to the App Load Balancer security group"
  default     = ["0.0.0.0/0"]
}

variable "alb_sg_egress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to allow outbound traffic from the App Load Balancer security group"
  default     = ["0.0.0.0/0"]
}

variable "launch_t_sg_egress_cidr_blocks" {
  type        = list(string)
  description = "List of CIDR blocks to allow outbound traffic from the ASG security group"
  default     = ["0.0.0.0/0"]
}

variable "launch_t_sg_name" {
  type        = string
  description = "Name of the ASG security group"
  default     = "Security Group for ASG"
}

variable "load_balancer_name" {
   type        = string
  description = "Name of the load balancer"
  default     = "pub-sub-alb"
}

variable "target_group_name" {
 type        = string
  description = "Name of the target group"
  default     = "alb-tg" 
}
variable "asg_name" {
   type        = string
  description = "Name of the ASG "
  default     = "ASG"
}

variable "asg_min" {
   type        = number
  description = "ASG Min Size"
  default     = 2
}

variable "asg_max" {
   type        = number
  description = "ASG Max Size"
  default     = 5
}

variable "asg_des_cap" {
  type        = number
  description = "ASG Desired Capacity"
  default     = 2
}

variable "lt_asg_name" {
  type        = string
  description = "Name of the Launch Template "
  default     = "lt-asg"
}

variable "lt_asg_ami" {
  type        = string
  description = "Amazon Linux 2 Ami ID"
  default     = "ami-04581fbf744a7d11f"
}

variable "lt_asg_instance_type" {
  type        = string
  description = "T2 Micro Instance Type"
  default     = "t2.micro"
}

variable "lt_asg_key" {
  type        = string
  description = "Key Pair"
  default     = "terrakey"
}

