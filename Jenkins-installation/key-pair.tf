resource "tls_private_key" "Jenkins-master" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "Jenkins-master" {
  key_name   = "Jenkins-master"
  public_key = tls_private_key.Jenkins-master.public_key_openssh
}

resource "local_file" "Jenkins-master" {
  content         = tls_private_key.Jenkins-master.private_key_pem
  filename        = "${path.module}/sshkeys/jenkins-master.pem"
  file_permission = "0600" # Set correct permissions for SSH private key
}

output "private_key_pem" {
  value     = tls_private_key.Jenkins-master.private_key_pem
  sensitive = true
}
