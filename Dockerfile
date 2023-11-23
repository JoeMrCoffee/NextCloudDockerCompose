FROM nextcloud
RUN apt update
RUN openssl req -x509 -nodes -days 1200 -newkey rsa:2048 -keyout /etc/ssl/private/ssl-cert-snakeoil.key -out /etc/ssl/certs/ssl-cert-snakeoil.pem -subj "/C=TW/ST=Taipei/L=Taipei/O=Global Security/OU=IT Department/CN=example.com"
RUN a2enmod ssl
RUN a2ensite default-ssl

EXPOSE 443
