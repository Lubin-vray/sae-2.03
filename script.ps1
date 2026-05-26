# Télécharge les images Docker nécessaires pour le projet
# Télécharge les images
docker pull mariadb:latest
docker pull wordpress:latest
docker pull phpmyadmin:latest

# Création du réseau dédié
docker network create --subnet 192.168.203.0/24 --gateway 192.168.203.1 sae23_vray

#crée un conteneur pour la base de données
docker run -d --name mariadb_vray --network sae23_vray -p 3306:3306 --env MARIADB_USER=lubin --env MARIADB_PASSWORD=lubin2007 --env MARIADB_DATABASE=database_lubin --env MARIADB_ROOT_PASSWORD=root --ip 192.168.203.10 --hostname mariadb_vray --add-host wordpress_vray:192.168.203.12 --add-host mariadb_vray:192.168.203.10 --add-host phpmyadmin_vray:192.168.203.11 --volume "C:\Users\lubin\Desktop\boulot\ecole\SAE2.03\badowordpress:/var/lib/mysql" mariadb:latest

#Interface phpMyAdmin
docker run -d --name phpmyadmin_vray --network sae23_vray --ip 192.168.203.11 --hostname phpmyadmin_vray --add-host mariadb_vray:192.168.203.10 --add-host wordpress_vray:192.168.203.12 --add-host phpmyadmin_vray:192.168.203.11 -p 9000:80 -e PMA_HOST=mariadb_vray phpmyadmin:latest

# Conteneur WordPress
docker run -d --name wordpress_vray --network sae23_vray -p 80:80 -e WORDPRESS_DB_HOST=mariadb_vray -e WORDPRESS_DB_USER=lubin -e WORDPRESS_DB_PASSWORD=lubin2007 -e WORDPRESS_DB_NAME=database_lubin --ip 192.168.203.12 --hostname wordpress_vray --add-host mariadb_vray:192.168.203.10 --add-host phpmyadmin_vray:192.168.203.11 --add-host wordpress_vray:192.168.203.12 --volume "C:\Users\lubin\Desktop\boulot\ecole\SAE2.03\htmlwordpress:/var/www/html" wordpress:latest


docker run -d --name mon-portfolio --network sae23_vray --ip 192.168.203.13 --hostname wordpress_vray --add-host mariadb_vray:192.168.203.10 --add-host phpmyadmin_vray:192.168.203.11 --add-host wordpress_vray:192.168.203.12 -p 90:80 webdevops/php-nginx

cd portfolio
docker build -t portfolio .
docker run -tid -p 82:80 --name portfolio portfolio       