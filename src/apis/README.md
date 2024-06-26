# Milsat Aspirant Program - API # map-api

A restful api system built with django for the Milsat Aspirant Programme

## Overview
This is the API for the Milsat Aspirant Program, built using Django. It runs on port 8000 and is accessible at [https://aspirant-api.milsat.africa/swagger/](https://aspirant-api.milsat.africa/swagger/).

## Installation

Note: If running locally, use map.settings-dev instead of map.settings.

1. Install dependencies:  # you can use a virtual environment
pip install -r requirements.txt

2. Set Django settings module:
export DJANGO_SETTINGS_MODULE=map.settings

3. Run database migrations:
python3 manage.py makemigrations --settings=map.settings
python3 manage.py migrate

4. Setup and start Gunicorn:
chmod +x restart_gunicorn.sh
./restart_gunicorn.sh

OR: Run the development server:
python3 manage.py runserver --settings=map.settings

If you are running this locally, you can access the API at [http://localhost:8000/swagger/](http://localhost:8000/swagger/).

5. Run the background worker (if you need to send emails): # Dont forget to start the redis server first
celery -A map worker -l info

7. Run the flower monitoring tool:
celery -A map flower

## Nginx as Reverse Proxy
Nginx is configured to serve this application on port 8000.

## Deployment
Automated via GitHub Actions using `.github/workflows/Api-Deployment.yml`.

### Note
The API interacts with a Postgres RDS database and uses a Redis database for background jobs.
