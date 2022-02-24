#!/bin/sh

if ! command -v docker > /dev/null  2>&1
then
    echo "Docker not found!"
    exit 1
fi

if ! command -v lando > /dev/null  2>&1
then
    echo "Lando not found!"
    exit 1
fi

if [ -f .git ] || [ -f .env ]
then
    echo "Opps! This seems to be a project directory. Run 'sites'"
    exit 1
fi

if [ -z "$1" ]
then
    echo "You must include your app name with the command. 'spin app_name'"
    exit 1
fi

docker run --rm --interactive --tty \
  --volume $PWD:/app \
  --user $(id -u):$(id -g) \
  composer create-project laravel/laravel $1 ^9.0 \
  && cd $1 \
  && lando init --source cwd --webroot ./public --recipe laravel --name $1

FILE=".lando.yml"
cat >> $FILE <<- EOM
  php: '8.1'
  via: apache
  database: mysql
  cache: redis
services:
  node:
    type: node:16
    scanner: false
    build:
      - npm install
  mail:
    type: mailhog
    portforward: true
    hogfrom:
      - appserver
tooling:
  migrate:
    service: appserver
    cmd: php artisan migrate
  npm:
    service: node
    cmd: npm
proxy:
  mail:
    - mail.$1.lndo.site
EOM
