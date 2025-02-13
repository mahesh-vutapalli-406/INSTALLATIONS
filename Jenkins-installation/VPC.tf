resource "aws_vpc" "Jenkins-master" {

  cidr_block = var.cidr_block

  instance_tenancy     = var.instance_tenancy
  enable_dns_hostnames = var.enable_dns_hostnames
  enable_dns_support   = var.enable_dns_support
  #enable_network_address_usage_metrics = var.enable_network_address_usage_metrics

  tags = local.tags
}

resource "aws_subnet" "Jenkins-master-public" {
  depends_on = [ aws_vpc.Jenkins-master ]
  availability_zone = var.availability_zone
  #availability_zone_id                           = length(regexall("^[a-z]{2}-", element(var.azs, count.index))) == 0 ? element(var.azs, count.index) : null
  cidr_block = var.public_subnet_cidr
  vpc_id     = aws_vpc.Jenkins-master.id

  tags = local.tags
}

resource "aws_internet_gateway" "Jenkins-master-internet-gw" {
  vpc_id = aws_vpc.Jenkins-master.id

  tags = local.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.Jenkins-master.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.Jenkins-master-internet-gw.id
  }

  tags = local.tags
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.Jenkins-master-public.id
  route_table_id = aws_route_table.public.id
}