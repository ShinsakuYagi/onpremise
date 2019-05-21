# !bin/sh

docker volume create --name=sentry-data && docker volume create --name=sentry-postgres

cp -n .env.example .env

docker-compose build

docker-compose run --rm web config generate-secret-key

echo \
echo 最下行のシークレットキーを'.env'の'SENTRY_SECRET_KEY'に設定してください
echo \

read -p "ok? (y/N): " yn
case "$yn" in [yY]*) ;; *) echo "abort."; rm ./.env ; exit ;; esac

docker-compose run --rm web upgrade

docker-compose up -d

open https://127.0.0.1:9000
