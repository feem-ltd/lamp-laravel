#!/bin/sh

echo "Building feem/lamp-node-laravel..."
docker build --file="build/laravel/Dockerfile" -t feem/lamp-node-laravel .

echo "Building feem/lamp-mysql..."
docker build --file="build/mysql/Dockerfile" -t feem/lamp-mysql .
