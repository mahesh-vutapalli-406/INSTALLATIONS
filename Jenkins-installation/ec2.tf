resource "aws_instance" "jenkins-master" {
  depends_on = [ aws_vpc.Jenkins-master,aws_subnet.Jenkins-master-public,aws_security_group.Jenkins-master-sg,aws_iam_instance_profile.Jenkins-master-instance-role ]
  ami           = data.aws_ami.ubuntu_latest.id
  instance_type = var.instance_type
  #cpu_core_count       = var.cpu_core_count
  #cpu_threads_per_core = var.cpu_threads_per_core
  #hibernation          = var.hibernation

  #user_data                   = data.local_file.jenkins-installation.content
  #user_data_replace_on_change = var.user_data_replace_on_change


  availability_zone      = var.availability_zone
  subnet_id              = aws_subnet.Jenkins-master-public.id
  vpc_security_group_ids = [aws_security_group.Jenkins-master-sg.id]

  key_name = aws_key_pair.Jenkins-master.key_name
  #monitoring           = var.monitoring
  #get_password_data    = var.get_password_data
  iam_instance_profile = aws_iam_instance_profile.Jenkins-master-instance-role.name

  associate_public_ip_address = var.associate_public_ip_address
  #private_ip                  = var.private_ip
  #secondary_private_ips       = var.secondary_private_ips
  #ipv6_address_count          = var.ipv6_address_count
  #ipv6_addresses              = var.ipv6_addresses

  #ebs_optimized = var.ebs_optimized
  root_block_device {
    volume_size           = 64
    volume_type           = "gp3"
    delete_on_termination = true
  }
  tags = local.tags

  connection {
    type     = "ssh"
     user    = "ec2-user"              # for Amazon Linux, "ubuntu" for Ubuntu
    private_key = tls_private_key.Jenkins-master.private_key_pem
    host     = self.public_ip
  }

  provisioner "file" {
    source      = "./installation-scripts/ubuntu-installation.sh"
    destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
}
