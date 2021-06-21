FROM debian:stable-slim  AS builder
RUN  apt update -y && pwd && ls -l && echo "当前目录$(pwd)"\
     wget https://raw.githubusercontent.com/hongwenjun/nginx-php/main/start.sh         --no-check-certificate && \
     wget https://raw.githubusercontent.com/hongwenjun/nginx-php/main/default          --no-check-certificate  && \
     wget https://raw.githubusercontent.com/hongwenjun/nginx-php/main/supervisord.conf --no-check-certificate   && \
     mv ./default  /etc/nginx/sites-enabled/default  && \
     mv ./supervisord.conf   /etc/supervisord.conf   && \
     chmod +x  /start.sh  && \
     ln -sf /dev/stdout /var/log/nginx/access.log  && \
     ln -sf /dev/stderr /var/log/nginx/error.log   && \
     echo "<?php phpinfo(); ?>"  > /var/www/html/index.php && \
     apt remove -y wget && \
     rm -rf /var/lib/apt/lists/*   /var/cache/apt

EXPOSE 80/tcp  443/tcp

FROM scratch
COPY --from=builder .  .

EXPOSE 80/tcp  443/tcp
CMD ["/start.sh"]

