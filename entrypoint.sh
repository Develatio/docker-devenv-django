#!/bin/bash

set -e

function wait_service {
    while ! nc -z $1 $2; do
        sleep 1
    done
}

case $1 in
    run-migrations)
        echo "--> Applying migrations"
        wait_service $REDIS_HOST $REDIS_PORT
        wait_service $DATABASE_HOST $DATABASE_PORT
        exec python manage.py migrate --noinput
        ;;
    run-runserver)
        echo "--> Starting Django's server"
        wait_service $REDIS_HOST $REDIS_PORT
        wait_service $DATABASE_HOST $DATABASE_PORT
        exec python manage.py runserver 0.0.0.0:8000
        ;;
    run-tests)
        echo "--> Starting Django's test framework"
        wait_service $REDIS_HOST $REDIS_PORT
        wait_service $DATABASE_HOST $DATABASE_PORT
        exec python manage.py test
        ;;
    run-celery)
        echo "--> Starting Celery queue"
        wait_service $REDIS_HOST $REDIS_PORT
        exec celery worker -A main -l info
        ;;
    run-celery-flower)
        echo "--> Starting Celery flower"
        wait_service $REDIS_HOST $REDIS_PORT
        exec celery flower -A main --port=5555
        ;;
    run-celery-beat)
        echo "--> Starting Celery beat"
        wait_service $REDIS_HOST $REDIS_PORT
        exec celery beat -A main -l info
        ;;
    *)
        exec "$@"
        ;;
esac
