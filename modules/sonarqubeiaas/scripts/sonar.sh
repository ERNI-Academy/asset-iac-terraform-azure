#!/bin/bash
export DEBIAN_FRONTEND=noninteractive
sudo apt-get update 
sudo apt-get install nginx python3-pip apt-transport-https ca-certificates curl software-properties-common -y

# Install docker
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo apt update
sudo apt install -y docker-ce

#Install Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.27.4/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

#Docker Compose for Sonarqube
OUT=/home/ubuntu/docker-compose.yml
cat <<'EOF' >$OUT
version: "3"

services:
  sonarqube:
    image: sonarqube:8.8-community
    restart: always
    depends_on:
      - db
    environment:
      SONAR_JDBC_URL: jdbc:postgresql://db:5432/sonar
      SONAR_JDBC_USERNAME: sonar
      SONAR_JDBC_PASSWORD: sonar
    volumes:
      - sonarqube_data:/opt/sonarqube/data
      - sonarqube_extensions:/opt/sonarqube/extensions
      - sonarqube_logs:/opt/sonarqube/logs
      - sonarqube_temp:/opt/sonarqube/temp
      - /home/ubuntu/sonarqube-community-branch-plugin-1.7.0.jar:/opt/sonarqube/extensions/plugins/sonarqube-community-branch-plugin.jar
      - /home/ubuntu/sonarqube-community-branch-plugin-1.7.0.jar:/opt/sonarqube/lib/common/sonarqube-community-branch-plugin.jar
    ports:
      - "9000:9000"
  db:
    image: postgres:12
    restart: always
    environment:
      POSTGRES_USER: sonar
      POSTGRES_PASSWORD: sonar
    volumes:
      - postgresql:/var/lib/postgresql
      - postgresql_data:/var/lib/postgresql/data

volumes:
  sonarqube_data:
  sonarqube_extensions:
  sonarqube_logs:
  sonarqube_temp:
  postgresql:
  postgresql_data:
EOF
#Nginx Configuration
CONF=/home/ubuntu/default
cat <<'EOF' >$CONF
server {
  listen 80 default;
  listen [::]:80 default;

  location / {
    proxy_pass http://127.0.0.1:9000;
    proxy_set_header Host $host;
    proxy_set_header X-Real-IP $remote_addr;
    proxy_set_header X-Forwarded-for $proxy_add_x_forwarded_for;
  }
  
}
EOF

cd /home/ubuntu
sudo mv default /etc/nginx/sites-available/default

# Download sonarqube plugin
wget https://github.com/mc1arke/sonarqube-community-branch-plugin/releases/download/1.7.0/sonarqube-community-branch-plugin-1.7.0.jar

#Configure sysctl.conf file so sonarqube can start successfully
sudo echo "vm.max_map_count=262144" >> /etc/sysctl.d/99-sysctl.conf && sudo sysctl --system
sudo echo "fs.file-max=65536" >> /etc/sysctl.d/99-sysctl.conf && sudo sysctl --system

sudo nginx -s reload
sudo docker-compose up -d