#!/bin/sh
#apt update --assume-yes
#apt install mysql-client --assume-yes

#while ! mysql-client ping -h "mysql" --silent; do
#    sleep 500
#done
sleep 10
# RUN the app (Lavagna)
java -Xms64m -Xmx128m -Ddatasource.dialect="${DB_DIALECT}" \
-Ddatasource.url="${DB_URL}" \
-Ddatasource.username="${DB_USER}" \
-Ddatasource.password="${DB_PASS}" \
-Dspring.profiles.active="${SPRING_PROFILE}" \
-jar target/lavagna-jetty-console.war --headless