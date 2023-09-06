# Docker Base Image
FROM python:3.11

# Install system dependencies
RUN apt-get update && apt-get install -y libpq-dev

# Set the working directory in the container
WORKDIR /app

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/
RUN pip install -r requirements.txt

# Copy the current directory contents into the container at /app/
COPY . /app/

# Make port 8000 available to the world outside this container
EXPOSE 8000

# # Do migrations
# CMD python manage.py migrate

RUN echo 'Migrations run'

# Run Django
CMD python manage.py runserver
