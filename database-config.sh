#!/bin/sh
source .secrets.sh

"${psql[@]}" --set=db_user="$DB_USER" --set=db_user_pass="$DB_USER_PASS"  --set=db_owner="$POSTGRES_USER"<<- 'EOSQL'
  CREATE USER :db_user WITH PASSWORD ':db_user_pass';
  
  CREATE DATABASE fire
    WITH OWNER = :db_owner
      TEMPLATE = 'template_postgis'
      ENCODING = 'UTF8'
      TABLESPACE = pg_default
      CONNECTION LIMIT = -1;

  GRANT SELECT ON ALL TABLES IN SCHEMA public TO :db_user;
EOSQL

psql fire < /sql/fire_db_2010.sql
