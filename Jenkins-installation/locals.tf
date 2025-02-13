locals {
  cidr_ipv4    = "${chomp(data.http.myip.response_body)}/32"
  CreationDate = { creationdate = formatdate("YYYY-MM-DD", timestamp()) }
  tags         = merge(var.tags, local.CreationDate)
}