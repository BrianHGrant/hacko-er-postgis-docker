#!/bin/sh

set -e

# Perform all actions as $POSTGRES_USER
export PGUSER="$POSTGRES_USER"

# Create the 'template_postgis' template db
"${psql[@]}" <<- 'EOSQL'
ALTER SYSTEM SET max_wal_size = 128;
CREATE DATABASE template_postgis;
UPDATE pg_database SET datistemplate = TRUE WHERE datname = 'template_postgis';
EOSQL

# Load PostGIS into both template_database and $POSTGRES_DB
for DB in template_postgis "$POSTGRES_DB"; do
	echo "Loading PostGIS extensions into $DB"
	"${psql[@]}" --dbname="$DB" <<-'EOSQL'
  CREATE EXTENSION postgis;
  CREATE EXTENSION fuzzystrmatch;
  CREATE EXTENSION postgis_topology;
	CREATE EXTENSION IF NOT EXISTS postgis_tiger_geocoder;
EOSQL
done
