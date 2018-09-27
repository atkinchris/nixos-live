#!/bin/bash
set -eu

function on_exit {
  docker-compose stop
  docker-compose kill
}

trap on_exit EXIT

docker-compose kill
docker-compose rm -vf
docker-compose build
docker-compose up --remove-orphans --abort-on-container-exit
