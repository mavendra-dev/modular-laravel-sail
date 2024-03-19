FROM webdevops/php-nginx:8.3-alpine

RUN apk add oniguruma-dev postgresql-dev libxml2-dev

COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

ENV WEB_DOCUMENT_ROOT /app/public

ENV APP_ENV production

ENV ALIAS_DOMAIN localhost

WORKDIR /app

COPY . .

RUN composer install --no-interaction --optimize-autoloader --no-dev

RUN php artisan config:cache

RUN php artisan route:cache

RUN php artisan view:cache

RUN chown -R application:application .
