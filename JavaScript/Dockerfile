FROM tsr2223/ubuntu-httpd
ADD misitio/index.html /var/www/html/index.html
ADD misitio/css /var/www/html/css
ADD misitio/js /var/www/html/js
ADD misitio/fonts /var/www/html/fonts
EXPOSE 80
CMD /usr/sbin/apache2ctl -D FOREGROUND
