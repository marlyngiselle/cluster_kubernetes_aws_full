#!/bin/bash
sudo apt update -y && sudo apt upgrade -y

sudo apt install -y default-jdk

VERSION_MAVEN="3.8.6"
sudo wget -P /tmp "https://dlcdn.apache.org/maven/maven-3/$VERSION_MAVEN/binaries/apache-maven-$VERSION_MAVEN-bin.tar.gz"
sudo tar -xf "/tmp/apache-maven-$VERSION_MAVEN-bin.tar.gz" -C /opt
sudo ln -s "/opt/apache-maven-$VERSION_MAVEN" /opt/maven


sudo touch /etc/profile.d/maven.bash

cat <<ANA | sudo tee -a /etc/profile.d/maven.bash
#!/bin/bash
export JAVA_HOME=/usr/lib/jvm/default-java
export M2_HOME=/opt/maven
export MAVEN_HOME=/opt/maven
export PATH=\$M2_HOME/bin:\$PATH
ANA
sudo chmod +x /etc/profile.d/maven.bash
. /etc/profile.d/maven.bash