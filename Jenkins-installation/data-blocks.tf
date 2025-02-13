data "aws_ami" "ubuntu_latest" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"] # Example for Ubuntu 20.04 LTS
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical's AWS Account ID (official Ubuntu images)
}

data "local_file" "jenkins-installation" {
  filename = "${path.module}/installation-scripts/installation.sh"
}

data "http" "myip" {
  url = "https://ipv4.icanhazip.com"
}