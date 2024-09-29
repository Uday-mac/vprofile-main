FROM mysql:8.0.33
LABEL "Author"="uday"
LABEL "Project"="vprofile"

ENV MYSQL_ROOT_PASSWORD="admin123"
ENV MYSQL_DATABASE="accounts"
ENV MYSQL_USER="root"


ADD db_backup.sql docker-entrypoint-initdb.d/db_backup.sql

