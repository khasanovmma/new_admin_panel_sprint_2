#!/bin/sh
python manage.py collectstatic --no-input
python manage.py migrate --no-input
python manage.py loaddata data.json

uwsgi --http :8000 --chdir /opt/app --module config.wsgi:application

exec "$@"