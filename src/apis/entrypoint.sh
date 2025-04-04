#!/bin/bash
set -e  # Exit immediately if a command exits with a non-zero status.

# Run database migrations
echo "Running Django migrations..."
python manage.py migrate --noinput

# Collect static files
echo "Collecting static files..."
python manage.py collectstatic --noinput

# Start Celery workers
echo "Starting Celery workers..."
celery -A map worker --loglevel=info --detach --concurrency=1

# Start Gunicorn
echo "Starting Gunicorn..."
exec "$@"
