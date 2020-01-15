FROM anapsix/alpine-java:8_server-jre

ENV PATH=/usr/local/bin:${PATH}


    # Prepare the container to install the software
RUN set -ex && \
    apk upgrade --update && \
    apk add --update curl mariadb mariadb-client supervisor && \
    rm -rf /var/cache/apk/* && \
    # Remove not needed tools
    apk del curl && \
    # Mysql
    mysql_install_db --user=mysql --rpm && \
    (mysqld_safe &) && \
    sleep 2  
    # mysql -u root -e "GRANT ALL ON druid.* TO 'druid'@'localhost' IDENTIFIED BY 'diurd'; CREATE database druid CHARACTER SET utf8;" && \

RUN apk   add maven


ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose ports:
# - 8081: HTTP (coordinator)
# - 8082: HTTP (broker)
# - 8083: HTTP (historical)
# - 3306: MySQL
# - 2181 2888 3888: ZooKeeper
# mysqld start --user=root


RUN rm -R /var/lib/mysql/*
RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql
 

COPY . /home/journals/

 
CMD ["mvn", "dependency:go-offline -B"]
COPY ./Code/target/journals-*jar  /home/journals/Code/target

EXPOSE 8080 3306 80
#WORKDIR /home/journals/
RUN chmod a+x /home/journals/*.sh
#RUN mysqld  --user=root  
ENTRYPOINT  /home/journals/docker-entrypoint.sh
#ENTRYPOINT export HOSTIP="$(resolveip -s $HOSTNAME)" && exec /usr/bin/supervisord -c /etc/supervisor/conf.d/supervisord.conf