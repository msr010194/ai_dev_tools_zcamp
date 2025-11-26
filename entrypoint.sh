#!/bin/bash
set -e

# Activate virtualenv if present (for local dev inside container build)
if [ -f "/app/.venv/bin/activate" ]; then
  source /app/.venv/bin/activate
fi

echo "Changing directory to project root if present..."
if [ -d "/app/01-todo/zcamp" ]; then
  cd /app/01-todo/zcamp
elif [ -d "/app/zcamp" ]; then
  cd /app/zcamp
fi

echo "Running migrations..."
python manage.py migrate --noinput

echo "Collecting static files..."
python manage.py collectstatic --noinput

echo "Starting: $@"
exec "$@"
