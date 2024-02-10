FROM dunglas/frankenphp:1.1-builder-php8.3

COPY --from=composer:latest /usr/bin/composer /usr/local/bin/composer

RUN install-php-extensions pcntl pdo pdo_pgsql zip

COPY . /app

WORKDIR /app

COPY --chown=root:root ./entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
