#!/bin/sh

[[ -z "$1" ]] && { echo "You must include your app name with the command. 'spin app_name'" ; exit 1; }

docker run --rm --interactive --tty \
  --volume $PWD:/app \
  --user $(id -u):$(id -g) \
  composer create-project laravel/laravel $1 ^9.0 \
  && cd $1 \
  && lando init --source cwd --webroot ./public --recipe laravel --name $1
