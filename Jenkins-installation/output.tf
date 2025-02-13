output "jenkins-installation-script" {
  value = data.local_file.jenkins-installation.content
}