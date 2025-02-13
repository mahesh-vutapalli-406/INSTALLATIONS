resource "aws_security_group" "Jenkins-master-sg" {
  depends_on = [ aws_vpc.Jenkins-master ]
  name        = "jenkins-master"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.Jenkins-master.id

  tags = local.tags
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  for_each          = { for key, value in var.ingress_rules : key => value }
  security_group_id = aws_security_group.Jenkins-master-sg.id
  cidr_ipv4         = local.cidr_ipv4
  from_port         = each.value.from_port
  ip_protocol       = each.value.ip_protocol
  to_port           = each.value.to_port
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.Jenkins-master-sg.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}
