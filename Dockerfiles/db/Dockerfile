FROM mysql:8.0.33
LABEL "Authoe"="uday"
LABEL "Project"="vprofile"

ENV MYSQL_ROOT_PASSWORD=admin
ENV MYSQL_DATABASE=accounts
ENV MYSQL_USER=admin

ADD db_backup.sql /docker-entrypoint-initdb.d

EXPOSE 3306

