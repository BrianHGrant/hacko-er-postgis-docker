FROM postgres:9.6
MAINTAINER Brian H. Grant <brian@bhgconcepts.com>

ENV POSTGIS_MAJOR 2.3
ENV POSTGIS_VERSION 2.3.2+dfsg-1~exp1.pgdg80+1

RUN apt-get update \
      && apt-get install -y --no-install-recommends \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR=$POSTGIS_VERSION \
           postgresql-$PG_MAJOR-postgis-$POSTGIS_MAJOR-scripts=$POSTGIS_VERSION \
           postgis=$POSTGIS_VERSION \
      && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /docker-entrypoint-initdb.d
RUN mkdir -p /sql

COPY ./initdb-postgis.sh /docker-entrypoint-initdb.d/0.sh
COPY ./database-config.sh /docker-entrypoint-initdb.d/1.sh
COPY ./fire_db_2010.sql /sql/fire_db_2010.sql
COPY ./bin/secrets.sh /.secrets.sh
