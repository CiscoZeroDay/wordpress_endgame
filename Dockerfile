FROM wordpress:6.3.1-php8.1-apache

# Installer unzip pour ton plugin
RUN apt-get update && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/*

# Copier le flag
COPY flag.txt /var/www/html/flag.txt

# Copier les plugins si besoin
COPY plugins /var/www/html/wp-content/plugins

# Permissions finales
RUN chown -R www-data:www-data /var/www/html \
    && find /var/www/html -type d -exec chmod 755 {} \; \
    && find /var/www/html -type f -exec chmod 644 {} \; \
    # Créer le dossier uploads si absent
    && mkdir -p /var/www/html/wp-content/uploads \
    && chown -R www-data:www-data /var/www/html/wp-content/uploads \
    && chmod -R 755 /var/www/html/wp-content/uploads \
    && rm -f /var/www/html/wp-content/uploads/.htaccess

# Autoriser les uploads PHP non filtrés
RUN echo "<?php define('ALLOW_UNFILTERED_UPLOADS', true); ?>" >> /var/www/html/wp-config.php

EXPOSE 80
