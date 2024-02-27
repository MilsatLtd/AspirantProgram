#!/bin/bash

export PATH="/home/ubuntu/.local/bin:$PATH"
# Gunicorn settings
APP_NAME="map.wsgi:application"
BIND_ADDRESS="0.0.0.0:8001"


echo "Restarting Gunicorn processes for $APP_NAME"

# Gracefully terminate the old Gunicorn processes
pkill -f "gunicorn $APP_NAME --bind $BIND_ADDRESS --daemon"

# Wait for a moment to ensure that the resources are freed
sleep 5

# Start a new Gunicorn daemon
gunicorn $APP_NAME --bind $BIND_ADDRESS --daemon

echo "Gunicorn restarted for $APP_NAME"

echo "Restarting Celery workers and Flower"

# # Stop previously running celery workers
# pkill -f "celery -A map worker -n test-celery-worker --loglevel=info --detach"
# pkill -f "celery -A map flower --node=test-flower --detach"

# Start a new celery worker
celery -A map worker --loglevel=info --detach

# Start a new flower
celery -A map flower


#Set the DJANGO_SETTINGS_MODULE Environment Variable
export DJANGO_SETTINGS_MODULE=map.settings_test

#Run Migrations
python3 manage.py migrate
