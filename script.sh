#!/bin/sh

# Executando o script para instalar o docker
curl -fsSL https://get.docker.com -o get-docker.sh
sh get-docker.sh


# Executando o script para instalar o docker-compose
sudo curl -L https://github.com/docker/compose/releases/download/v2.5.0/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose


# Criando um contêiner de wordpress com docker-compose.yml 
echo 'version: "3.1"

services:

  wordpress:
    image: wordpress
    restart: always
    ports:
      - 8080:80
    environment:
      WORDPRESS_DB_HOST: db
      WORDPRESS_DB_USER: exampleuser
      WORDPRESS_DB_PASSWORD: examplepass
      WORDPRESS_DB_NAME: exampledb
    volumes:
      - wordpress:/var/www/html

  db:
    image: mysql:8.0
    restart: always
    environment:
      MYSQL_DATABASE: "namedb"
      MYSQL_USER: "user_sql"
      MYSQL_PASSWORD: "senhauser"
      MYSQL_RANDOM_ROOT_PASSWORD: 'GAud4mZby8F3SD6P'
    volumes:
      - db:/var/lib/mysql

volumes:
  wordpress:
  db:' > docker-compose.yml


# Executando um contêiner de wordpress com docker-compose.yml 
docker-compose up -d


# Criando um arquivo index.html para inserir no dockerfile
echo '<html lang="pt-br">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
  .center {
    text-align: center;
  }
</style>
</head>
<body>
  <div class="center">
    <h1>Desafio Extra Minsait</h1>
  </div>
</body>
</html>' > index.html


#Criando um arquivo Dockerfile
echo 'FROM debian:latest

RUN apt-get update && apt-get install -y apache2 
ENV APACHE_LOCK_DIR="/var/lock"
ENV APACHE_PID_FILE="/var/run/apache2.pid"
ENV APACHE_RUN_USER="www-data"
ENV APACHE_RUN_GROUP="www-data"
ENV APACHE_LOG_DIR="/var/log/apache2"

COPY index.html /var/www/html/

LABEL description="Webserver"


VOLUME /var/www/html/
EXPOSE 80

CMD ["/usr/sbin/apachectl","-D" ,"FOREGROUND"]' > Dockerfile


#Construindo um arquivo Dockerfile
docker image build -t web_serv:1.0 .


#Executando um arquivo Dockerfile
docker run -d -p 8000:80 web_serv:1.0