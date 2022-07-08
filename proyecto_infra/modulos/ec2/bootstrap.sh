#!/bin/bash
NOMBRE_SERVIDOR=pepito
sudo hostnamectl set-hostname $NOMBRE_SERVIDOR

sudo timedatectl set-timezone Europe/Paris

sudo sed -i 's/^%sudo.*/%sudo   ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers

sudo sed -i 's/^PasswordAuthentication.*/PasswordAuthentication yes/g' /etc/ssh/sshd_config
sudo sed -i 's/#PubkeyAuthentication.*/PubkeyAuthentication yes/g' /etc/ssh/sshd_config
sudo systemctl restart sshd

sudo mkdir -p /home/ansible/.ssh
sudo chmod 700 /home/ansible/.ssh
sudo chown ansible:ansible /home/ansible/.ssh/

sudo touch /home/ansible/.ssh/authorized_keys
sudo chmod 600 /home/ansible/.ssh/authorized_keys
sudo chown ansible:ansible /home/ansible/.ssh/authorized_keys
echo "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJcIqesf51uFB2a9tqLpJi70sNW7O9rBDTgBX8WWnMNN Ansible" | sudo tee -a /home/ansible/.ssh/authorized_keys 
sudo chown -R ansible:ansible /home/ansible

USUARIO=ansible
CONTRASENA=123

sudo useradd -m -s /bin/bash -G sudo $USUARIO
echo "$USUARIO:$CONTRASENA" | sudo chpasswd


sudo touch /etc/sudoers.d/$USUARIO
sudo chmod 440 /etc/sudoers.d/$USUARIO
echo "$USUARIO ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee /etc/sudoers.d/$USUARIO

echo "ubuntu:$contrasena" | sudo chpasswd

sudo sed -i 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' /etc/sudoers

sudo ufw disable

cat<<ALO | sudo tee -a /etc/host
#DNS Locales
10.0.150.200 bastion bt
10.0.150.10  jmaster jenkins
10.0.150.11  jagent1 agent1
10.0.150.12  jagent2 agent2
10.0.150.20  nexus
10.0.150.50  ansible
10.0.150.70  docker
10.0.150.90  kmaster km
10.0.150.91  kworker1 kw1
10.0.150.92  kworker2 kw2
ALO

sudo apt-get update
sudo apt-get upgrade -y 
sudo apt-get install -y wget curl git


