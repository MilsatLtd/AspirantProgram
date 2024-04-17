# Milsat Aspirant Program - API # map-api

A restful api system built with django for the Milsat Aspirant Programme

## Overview
This is the API for the Milsat Aspirant Program, built using Django. It runs on port 8000 and is accessible at [https://aspirant-api.milsat.africa/swagger/](https://aspirant-api.milsat.africa/swagger/).

## Installation

1. Install dependencies:
pip install -r requirements.txt

2. Set Django settings module:
export DJANGO_SETTINGS_MODULE=map.settings

3. Run database migrations:
python3 manage.py makemigrations --settings=map.settings
python3 manage.py migrate

4. Setup and start Gunicorn:
chmod +x restart_gunicorn.sh
./restart_gunicorn.sh

## Nginx as Reverse Proxy
Nginx is configured to serve this application on port 8000.

## Deployment
Automated via GitHub Actions using `.github/workflows/Api-Deployment.yml`.

### Note
The API interacts with a Postgres RDS database and uses a Redis database for background jobs.
