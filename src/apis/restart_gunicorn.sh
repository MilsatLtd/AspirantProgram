#!/bin/bash

export PATH="/home/ubuntu/.local/bin:$PATH"
# Gunicorn settings
APP_NAME="map.wsgi:application"
BIND_ADDRESS="0.0.0.0:8000"

echo "Restarting Gunicorn processes for $APP_NAME"

# Gracefully terminate the old Gunicorn processes
pkill -f "gunicorn.*$APP_NAME"

# Wait for a moment to ensure that the resources are freed
sleep 5

# Start a new Gunicorn daemon
gunicorn $APP_NAME --bind $BIND_ADDRESS &

echo "Gunicorn restarted for $APP_NAME"

#Set the DJANGO_SETTINGS_MODULE Environment Variable
export DJANGO_SETTINGS_MODULE=map.settings

#Run Migrations
python3 manage.py migrate
