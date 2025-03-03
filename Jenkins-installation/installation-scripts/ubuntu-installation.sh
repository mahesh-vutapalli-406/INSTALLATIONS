#!/bin/bash

# Update the system
sudo apt update -y
sudo apt upgrade -y

# Install Java 17
sudo apt install openjdk-17-jdk -y

# Verify Java Version
java -version

# Add Jenkins Key and Repo
curl -fsSL https://pkg.jenkins.io/debian-stable/jenkins.io-2023.key | sudo tee \
  /usr/share/keyrings/jenkins-keyring.asc > /dev/null

echo "deb [signed-by=/usr/share/keyrings/jenkins-keyring.asc] \
https://pkg.jenkins.io/debian-stable binary/" | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null

# Update after adding Jenkins repo
sudo apt update -y

# Install Jenkins
sudo apt install jenkins -y

# Start and Enable Jenkins Service
sudo systemctl enable jenkins
sudo systemctl start jenkins


# Display Jenkins Status
#sudo systemctl status jenkins
