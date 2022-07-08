#!/bin/bash
sudo apt update -y && sudo apt upgrade -y

# Instalar Docker
sudo apt remove docker docker-engine docker.io containerd runc
sudo apt update -y && sudo apt upgrade -y
sudo apt install -y ca-certificates curl gnupg lsb-release
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update -y
sudo apt install -y docker-ce docker-ce-cli containerd.io
sudo usermod -aG docker $USER
sudo usermod -aG docker ansible
sudo systemctl start docker
sudo systemctl enable docker

# Crear carpeta para nexus
mkdir -p ~/neo-nexus
sudo chown -R 200 ~/neo-nexus
cd ~/neo-nexus

sudo su - $USER

#Correr contenedor con imagen llamada sonatype/nexus3 y permitir 2 puertos (uno para el portalweb y otra para pushar)
docker run -d -p 8081:8081 -p 8085:8085 -v ~/neo-nexus:/nexus-data --name contenedor_nexus sonatype/nexus3

