# output "jenkins-installation-script" {
#   value = data.local_file.jenkins-installation.content
# }

output "ec2_public_IP" {
  value = aws_instance.jenkins-master.public_dns
}