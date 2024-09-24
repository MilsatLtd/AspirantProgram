from celery import shared_task
import html2text
from django.core.mail import send_mail
from django.conf import settings
from .models import Cohort
from .common.enums import *
import logging


logger = logging.getLogger(__name__)

sender = settings.DEFAULT_FROM_EMAIL


@shared_task()
def cohort_apply_to_live(cohort_id):
    try:
        cohorts = Cohort.objects.filter(
            status=COHORT_STATUS.UPCOMING.value, cohort_id=cohort_id)
        for cohort in cohorts:
            cohort.status = COHORT_STATUS.ACTIVE.value
            cohort.save()
    except Exception as e:
        logger.exception(e)


@shared_task()
def cohort_live_to_end(cohort_id):
    try:
        cohorts = Cohort.objects.filter(
            status=COHORT_STATUS.ACTIVE.value, cohort_id=cohort_id)
        for cohort in cohorts:
            cohort.status = COHORT_STATUS.ENDED.value
            cohort.save()
    except Exception as e:
        logger.exception(e)

def send_html_email_task(subject=None, recipient=None, message=None):
    try:
        plaintext = html2text.HTML2Text().handle(message)
        send_mail(subject, plaintext, sender, recipient, html_message=message, fail_silently=False)
    except Exception as e:
        logger.exception(e)

@shared_task(bind=True, max_retries=1, default_retry_delay=1 )
def send_html_email_task2(self, subject=None, recipient=None, message=None):
    try:
        import time
        time.sleep(30)
        plaintext = html2text.HTML2Text().handle(message)   
        send_mail(subject, plaintext, sender, recipient, html_message=message, fail_silently=False)
    except Exception as e:
        logger.exception(e)
        raise e