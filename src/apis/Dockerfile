FROM python:3.11.3

ENV PYTHONUNBUFFERED 1

RUN apt-get install -y \
    libpq-dev gcc curl \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt /app/

RUN pip install --no-cache-dir -r requirements.txt

COPY . /app/

EXPOSE 8000

RUN chmod +x /app/entrypoint.sh

ENV DJANGO_SETTINGS_MODULE=map.settings

ENTRYPOINT ["/app/entrypoint.sh"]

CMD ["gunicorn", "map.wsgi:application", "--bind", "0.0.0.0:8000"]
