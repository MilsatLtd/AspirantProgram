#!/bin/bash

export PATH="/home/ubuntu/.local/bin:$PATH"
# Gunicorn settings
MAP_APP_NAME="map.wsgi:application"
BIND_ADDRESS="0.0.0.0:8001"

echo "Restarting Gunicorn processes for $MAP_APP_NAME"

# Gracefully terminate the old Gunicorn processes
# pkill -f "gunicorn.*$MAP_APP_NAME"

# Wait for a moment to ensure that the resources are freed
sleep 5

# Start a new Gunicorn daemon
gunicorn $MAP_APP_NAME --bind $BIND_ADDRESS --daemon &

echo "Gunicorn restarted for $MAP_APP_NAME"

#Set the DJANGO_SETTINGS_MODULE Environment Variable
export DJANGO_SETTINGS_MODULE=map.settings_test

#Run Migrations
python3 manage.py migrate
