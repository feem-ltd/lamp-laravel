#!/bin/sh

echo "Building feem/lamp-silicense..."
docker build --file="build/laravel/Dockerfile" --target production -t feem/lamp-silicense .
echo "\n"

echo "Building feem/lamp-mysql..."
docker build --file="build/mysql/Dockerfile" -t feem/lamp-mysql .
echo "\n"
