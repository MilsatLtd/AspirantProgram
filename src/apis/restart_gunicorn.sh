#!/bin/bash

export PATH="/home/ubuntu/.local/bin:$PATH"
# Gunicorn settings
APP_NAME="map.wsgi:application"
BIND_ADDRESS="0.0.0.0:8000"

echo "Restarting Gunicorn processes for $APP_NAME"

# Gracefully terminate the old Gunicorn processes
pkill -f "gunicorn $APP_NAME --bind $BIND_ADDRESS --daemon"

# Stop previously running celery workers
pkill -f "celery"

echo "Old gunicorn and celery workers terminated successfully"

# Wait for a moment to ensure that the resources are freed
sleep 5

# # Start redis-server
# echo "Starting redis-server"
# redis-server --daemonize yes

# Start a new celery worker
echo "Starting Celery workers and Flower"
celery -A map flower --persistent=True & celery -A map worker --loglevel=info --detach
echo "Celery workers and Flower started successfully"

# Start a new Gunicorn daemon
gunicorn $APP_NAME --bind $BIND_ADDRESS --daemon

echo "Gunicorn restarted for $APP_NAME"

#Set the DJANGO_SETTINGS_MODULE Environment Variable
export DJANGO_SETTINGS_MODULE=map.settings

#Run Migrations
python3 manage.py migrate
