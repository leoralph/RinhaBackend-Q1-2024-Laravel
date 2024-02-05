FROM dunglas/frankenphp:1.1-builder-php8.3

RUN install-php-extensions pcntl

COPY . /app

WORKDIR /app

EXPOSE 8000

ENTRYPOINT [ "php", "artisan", "octane:start", "--host=0.0.0.0" ]
