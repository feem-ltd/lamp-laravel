@echo off

docker build --file="build/nginx/Dockerfile" -t feem/lamp-nginx .
docker build --file="build/mariadb/Dockerfile" -t feem/lemp-mysql .
docker build --file="build/laravel/Dockerfile.production" -t feem/lemp-node-laravel .

