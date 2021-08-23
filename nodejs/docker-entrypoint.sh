#!/bin/sh
set -ea


if [ "$1" = "npm" ]; then

  # if [ ! -f "package.json" ]; then

  #   DATABASE_CLIENT=${DATABASE_CLIENT:-sqlite}

  #   EXTRA_ARGS=${EXTRA_ARGS}

  #   echo "No project found at /srv/app. Creating a new  project"

  #   DOCKER=true vue new . \
  #     --dbclient=$DATABASE_CLIENT \
  #     --dbhost=$DATABASE_HOST \
  #     --dbport=$DATABASE_PORT \
  #     --dbname=$DATABASE_NAME \
  #     --dbusername=$DATABASE_USERNAME \
  #     --dbpassword=$DATABASE_PASSWORD \
  #     --dbssl=$DATABASE_SSL \
  #     $EXTRA_ARGSs

  # elif [ ! -d "node_modules" ] || [ ! "$(ls -qAL node_modules 2>/dev/null)" ]; then

  if [ ! -d "node_modules" ] || [ ! "$(ls -qAL node_modules 2>/dev/null)" ]; then

    echo "Node modules not installed. Installing..."

    if [ -f "yarn.lock" ]; then

      yarn install

    else

      npm install

    fi

  fi

fi

echo "Starting your app..."

echo "exec $@"
exec "$@"