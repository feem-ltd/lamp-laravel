@echo off

echo Building feem/lamp-node-laravel...
docker build --file="build/laravel/Dockerfile" --target development -t feem/lamp-node-laravel .
echo;

echo Building feem/lamp-mysql...
docker build --file="build/mysql/Dockerfile" -t feem/lamp-mysql .
echo;
