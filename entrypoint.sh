#!/bin/bash
set -e

# Activate virtualenv if present (for local dev inside container build)
if [ -f "/app/.venv/bin/activate" ]; then
  source /app/.venv/bin/activate
fi

echo "Changing directory to project root if present..."
if [ -f "/app/01-todo/zcamp/manage.py" ]; then
  cd /app/01-todo/zcamp
elif [ -f "/app/zcamp/manage.py" ]; then
  cd /app/zcamp
fi

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting: $@"
exec "$@"
