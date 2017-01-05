FROM ubuntu:16.04
MAINTAINER Leo <root@workgroup.cn>

ENV IP 192.168.99.100

#Update source

ADD sources.list /etc/apt/sources.list
ADD start.sh /

RUN apt update -y && \
    apt upgrade -y && \
    apt install nginx php-fpm php-gd php-mysql php-mbstring php-xdebug php-redis php-curl php-pgsql -y && \
    rm -rf /var/lib/apt/lists/* && \

#xdebug configure

    sed -i  'a xdebug.remote_enable=1;\nxdebug.remote_handler=dbgp;\nxdebug.remote_host=$IP;\nxdebug.remote_connect_back=1;\nxdebug.remote_port=8901;\nxdebug.idekey="leo";\nxdebug.var_display_max_depth=-1;\nxdebug.var_display_max_children=-1;\nxdebug.var_display_max_data=-1;'  /etc/php/7.0/fpm/conf.d/20-xdebug.ini  && \
    chmod +x /start.sh && \
    mkdir -p /Users/leo/www 

VOLUME ["/etc/nginx/sites-enabled", "/Users/leo/www"]
EXPOSE 80 443 8901


CMD ["/start.sh"]




