#!/bin/bash
set -e

echo "Changing directory to project root..."
if [ -f "/app/01-todo/zcamp/manage.py" ]; then
  cd /app/01-todo/zcamp
fi

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting: $@"
exec "$@"
