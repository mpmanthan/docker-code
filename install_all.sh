#!/bin/bash

sudo apt-get update
sudo apt-get install -y apache2 docker.io
sudo systemctl start apache2
sudo systemctl start docker
sudo systemctl enable docker

sudo echo 'Hello Welcome to My Web Page' > index.html

sudo cat > dockerfile <<EOF
FROM centos:7
WORKDIR app
RUN yum install httpd -y
COPY index.html /var/www/html
CMD ["/usr/sbin/httpd","-D","FOREGROUND"]
EXPOSE 80
EOF

sudo docker build -t solo:v1 .
sudo docker run -d -p 80:8080 -name xyz solo:v1





