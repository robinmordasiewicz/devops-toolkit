FROM nginx:latest
# FROM nginxinc/nginx-unprivileged
# COPY site /usr/share/nginx/html
COPY site /www/

COPY docs.conf /etc/nginx/conf.d/docs.conf
# COPY .htpasswd /etc/nginx/.htpasswd
