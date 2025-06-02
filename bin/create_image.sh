#!/usr/bin/bash

if docker image inspect playwright-app >/dev/null 2>&1; then
    echo "You already have the docker images"
    exit
fi

echo "Building the latest app image"
docker compose build app \
    --build-arg DOCKER_USER="$(whoami)"
docker compose up -d app