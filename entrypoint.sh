#!/bin/sh

cd /app

composer install --optimize-autoloader --no-dev

#if not exist .env
if [ ! -f ".env" ]; then
    cp .env.example .env
    php artisan key:generate
fi

php artisan config:cache
php artisan event:cache
php artisan route:cache
php artisan view:cache

php artisan migrate --force

php artisan octane:start --host=0.0.0.0 --max-requests=100000
