#!/bin/bash

mix deps.get

# Wait until Postgres is ready
while ! pg_isready -q -h db -p 5432 -U postgres
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

if [[ -z `psql -Atqc "\\list the_rush_backend_dev"` ]]; then
  echo "Database does not exist. Creating..."
  mix ecto.create
  mix ecto.migrate
  mix run priv/repo/seeds.exs
fi

exec mix phx.server
