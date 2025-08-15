FROM wordpress:6.3.1-php8.1-apache

# Installer unzip pour ton plugin
RUN apt-get update && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/*

# Copier le flag
COPY flag.txt /var/www/html/flag.txt

# Permissions finales
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \;

EXPOSE 80
