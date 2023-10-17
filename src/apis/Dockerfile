# Docker Base Image
FROM python:3.9

# Install system dependencies
RUN apt-get update && apt-get install -y gcc libpq-dev

# Set the working directory in the container
WORKDIR /app

# Install any needed packages specified in requirements.txt
COPY requirements.txt /app/
RUN pip install --no-cache-dir -r requirements.txt

# Copy the current directory contents into the container at /app/
COPY . /app/

# Run gunicorn
CMD ["gunicorn", "map.wsgi:application", "--bind", "0.0.0.0:8000"]
