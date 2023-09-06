# Use Ubuntu 22.04 as the base image
FROM ubuntu:22.04 AS base

# Set working directory
WORKDIR /app

# Update package list and install dependencies
RUN apt-get update -y && \
    apt-get install python3-pip sudo ufw build-essential libpq-dev libmysqlclient-dev python3-dev default-libmysqlclient-dev libpython3-dev -y

# Cache dependencies
COPY requirements.txt .
RUN python3 -m pip install --upgrade setuptools && \
    python3 -m pip install -r requirements.txt

# Application code is added here
COPY . /app

# Run firewall and other setups
RUN sudo ufw allow 8000

# Expose the application port
EXPOSE 8000

# # Run your application (Modify this as per your needs)
# CMD ["python3", "your_app.py"]
# Run Django
# CMD ["gunicorn", "map.wsgi:application", "--bind", "0.0.0.0:8000"]
