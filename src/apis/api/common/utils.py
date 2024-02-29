from django.core.mail import send_mail
from django.conf import settings
from celery import shared_task

import logging
logger = logging.getLogger(__name__)


@shared_task(bind=True, max_retries=5, default_retry_delay=3600 ) #Retry after 1 hour
def sendEmail(self, recipient=None, subject=None, message=None):
    try:
        sender = settings.EMAIL_HOST_USER
        send_mail(subject, message, sender, [recipient], fail_silently=False)
    except Exception as e:
        logger.exception(e)
        raise e
