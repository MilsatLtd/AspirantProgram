import os
from celery import Celery   

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'map.settings')

app = Celery('map')
app.conf.update(timezone='Africa/Lagos')

app.config_from_object('django.conf:settings', namespace='CELERY')

app.autodiscover_tasks()
