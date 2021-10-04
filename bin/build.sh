#!/bin/sh

docker build --file="build/laravel/Dockerfile" --target development -t feem/lamp-node-laravel .

docker build --file="build/mysql/Dockerfile" -t feem/lamp-mysql .
