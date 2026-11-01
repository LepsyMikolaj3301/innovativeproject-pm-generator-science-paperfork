#!/bin/bash

DEL_VOLUMES=false

while [[ "$#" -gt 0 ]]; do
  case "$1" in
    -v | --volumes) DEL_VOLUMES=true  ;;
    *) echo "unknown flag: $1" >&2 ; exit 1;
  esac
  shift
done

echo "Stopping genpm containers..."

if $DEL_VOLUMES; then
  docker compose --env-file .env -f infra/docker-compose.yml down -v
else
  docker compose --env-file .env -f infra/docker-compose.yml down
fi
