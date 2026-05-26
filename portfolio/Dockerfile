FROM debian:latest

# Installation d'Apache et PHP
RUN apt update && apt install apache2 -y
RUN apt update && apt install php libapache2-mod-php -y
RUN apt update && apt install php-xml php-mbstring php-intl php-mysql -y
RUN apt update && apt install zip -y
RUN apt update && apt install curl -y

# Installation de Composer
# Installation de Composer
RUN php -r "copy('https://getcomposer.org/installer', '/root/composer-setup.php');"
RUN php /root/composer-setup.php --install-dir="/usr/local/bin" --filename=composer

# Installation de Git
RUN apt update && apt install git -y

# Clonage du projet
RUN git clone https://github.com/Lubin-vray/eportfolio.git /var/www/html/site

# Définir le répertoire de travail
WORKDIR /var/www/html/site

# Installation des dépendances Symfony
RUN composer install --no-interaction

# Copie de la configuration Apache
COPY site.conf /etc/apache2/sites-available/site.conf

# Activation du site et des modules Apache
RUN a2ensite site.conf
RUN a2enmod rewrite
RUN a2dissite 000-default.conf

# Droits sur le dossier
RUN chown -R www-data:www-data /var/www/html/site/
RUN chmod -R 755 /var/www/html/site/

# Port exposé
EXPOSE 80

# Démarrage d'Apache
CMD ["/bin/bash", "-c", "/usr/sbin/service apache2 start && tail -f /dev/null"]