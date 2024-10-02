#!/bin/bash

export PATH="/home/ubuntu/.local/bin:$PATH"
APP_NAME="map.wsgi:application"
BIND_ADDRESS="0.0.0.0:8000"

echo "Restarting Gunicorn processes for $APP_NAME"

# Gracefully terminate the old Gunicorn processes
pkill -f "gunicorn $APP_NAME --bind $BIND_ADDRESS --daemon"

# Stop previously running Celery workers
pkill -f "celery -A map worker -n prod-celery --concurrency=10 --prefetch-multiplier=1 --task-acks-late=True --loglevel=info --detach"

echo "Old Gunicorn and Celery workers terminated successfully"

# Wait for a moment to ensure that resources are freed
sleep 5

# Start a new Celery worker and Flower
echo "Starting Celery workers"
# celery -A map flower --persistent=True --port=5454 --loglevel=info --basic_auth=admin@milsat.com:https://github.com/MilsatLtd/MilsatAPI/pull/917
celery -A map worker -n prod-celery --concurrency=10 --prefetch-multiplier=1 --task-acks-late=True --loglevel=info --detach 
echo "Celery workers started successfully"

# Start a new Gunicorn daemon
echo "Starting Gunicorn"
gunicorn $APP_NAME --bind $BIND_ADDRESS --daemon

echo "Gunicorn restarted for $APP_NAME"

# Set the DJANGO_SETTINGS_MODULE Environment Variable
export DJANGO_SETTINGS_MODULE=map.settings

# Run Migrations
echo "Running Django migrations"
python3 manage.py migrate

echo "Script completed successfully"
