#!/bin/sh
python manage.py collectstatic --no-input
python manage.py migrate --no-input

echo "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.create_superuser('admin', 'admin@admin.ru', '$SUPER_USER_PASS') if not User.objects.filter(username='admin').exists() else 0" | python manage.py shell

uwsgi --http :8000 --chdir /opt/app --module config.wsgi:application

exec "$@"