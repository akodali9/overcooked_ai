#!/bin/sh
if [ "$(echo "$1" | cut -c1-4)" = "prod" ];
then
    echo "production"
    export BUILD_ENV=production

    # Completely re-build all images from scratch without using build cache
    docker compose build --no-cache
    docker compose up --force-recreate -d
else
    echo "development"
    export BUILD_ENV=development
    # Uncomment the following line if there has been an update to overcooked-ai
    # docker compose build --no-cache

    # Force re-build of all images but allow use of build cache if possible
    docker compose up --build
fi