variable "instance_type" {
  default     = "m5.large"
  type        = string
  description = "Instance type size for jenkins-master"
}


variable "region" {
  default     = "us-east-1"
  type        = string
  description = "AWS region for services deployment"
}

variable "availability_zone" {
  default     = "us-east-1a"
  type        = string
  description = "aws us-east availability zone"
}

variable "cidr_block" {
  default     = "176.0.0.0/16"
  description = "VPC CIDR range"
}

variable "enable_ipv6" {
  default     = false
  description = "to enable the ipv6 during VPC creation"
  type        = bool
}

variable "instance_tenancy" {
  default     = "default"
  type        = string
  description = "Instances launched into the VPC run on shared hardware or dedicated. Accepted values 'default' or 'dedicated'"
}

variable "enable_dns_hostnames" {
  default     = true
  description = "The enable_dns_hostnames attribute in an AWS VPC determines whether EC2 instances in the VPC get public DNS hostnames if they have public IP addresses"
  type        = bool
}

variable "enable_dns_support" {
  default     = true
  type        = bool
  description = "The enable_dns_hostnames attribute in an AWS VPC determines whether EC2 instances in the VPC get public DNS hostnames if they have public IP addresses"
}

variable "tags" {
  type        = map(string)
  description = "tags for the aws resources"
  default = {
    "Name"      = "Jenkins-master"
    "Purpose"   = "Learning"
    "createdBy" = "Mahesh"
  }
}

variable "public_subnet_cidr" {
  default     = "176.0.0.0/25"
  description = "public subnet VPC ID"
  type        = string
}


variable "ingress_rules" {
  type        = list(map(string))
  description = "Ingress rules"
  default = [{
    from_port   = 80
    ip_protocol = "tcp"
    to_port     = 80
    },
    {
      from_port   = 8080
      ip_protocol = "tcp"
      to_port     = 8080
    },
    {
      from_port   = 22
      ip_protocol = "tcp"
      to_port     = 80
    }
  ]
}

variable "associate_public_ip_address" {
  type        = bool
  default     = true
  description = "flag to assign a public IP to instance"
}


variable "user_data_replace_on_change" {
  default     = true
  type        = bool
  description = "user_data_replace_on_change is an argument in the aws_instance resource in Terraform that controls whether the EC2 instance will be replaced if the user_data value is changed."
}