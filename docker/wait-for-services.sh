#! /bin/sh

# Wait for PostgreSQL
until curl $DB_HOST:5432 2>&1 | grep '52'; do
do
  echo 'Waiting for PostgreSQL...'
  sleep 1
done
echo "PostgreSQL is up and running"