FROM postgres

ENV TZ Africa/Dar_es_Salaam

# set time zone
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# add backup job
RUN mkdir -p /opt/backups
COPY ./pgbackup.sh /opt/pgbackup.sh
RUN chmod +x /opt/pgbackup.sh

# add init script
RUN mkdir -p /docker-entrypoint-initdb.d
COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/postgis.sh

# create volume for backups
VOLUME ["/opt/backups"]