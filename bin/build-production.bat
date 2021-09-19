@echo off

docker build --file="build/nginx/Dockerfile" -t feem/lemp-nginx .
docker build --file="build/laravel/Dockerfile" -t feem/lemp-node-laravel .
docker build --file="build/laravel/Dockerfile.production" -t feem/lemp-silicense .
docker build --file="build/mariadb/Dockerfile" -t feem/lemp-mariadb .
