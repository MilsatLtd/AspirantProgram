import os
from celery import Celery 
from api.logging import SlackLogHandler  

os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'map.settings_dev')

app = Celery('map')
app.conf.update(timezone='Africa/Lagos')

# set up custom logger for celery
import logging
from celery.signals import setup_logging
from celery.utils.log import get_task_logger

@setup_logging.connect
def on_celery_setup_logging(**kwargs):
    logger = get_task_logger(__name__)
    logger.setLevel(logging.ERROR)
    logger.addHandler(app.config.logging.handlers.slack)
    logger.addHandler(app.config.logging.handlers.file)
app.config_from_object('django.conf:settings', namespace='CELERY')

app.autodiscover_tasks()
