from django.core.mail import send_mail
from django.conf import settings
from celery import shared_task
import time

import logging
logger = logging.getLogger(__name__)


# @shared_task(bind=True, max_retries=5, default_retry_delay=3600 ) #Retry after 1 hour
# def sendEmail(self, recipient=None, subject=None, message=None):
#     try:
#         sender = settings.DEFAULT_FROM_EMAIL
#         send_mail(subject, message, sender, [recipient], fail_silently=False)
#     except Exception as e:
#         logger.exception(f"Error occured while sending email to {recipient}", e)
#         raise e
 
def sendEmail(recipient=None, subject=None, message=None):
    max_retries = 3
    base_delay = 120 # Start with 1 second delay

    for attempt in range(max_retries):
        try:
            logger.info(f"Attempt {attempt + 1}/{max_retries}: Sending email to {recipient} with subject {subject}")
            sender = settings.DEFAULT_FROM_EMAIL
            send_mail(subject, message, sender, [recipient], fail_silently=False)
            logger.info(f"Email sent successfully to {recipient}")
            return 
        except Exception as e:
            logger.warning(f"Attempt {attempt + 1}/{max_retries} failed for {recipient}: {e}")
            if attempt < max_retries - 1:
                delay = base_delay * (2 ** attempt) # Exponential backoff
                logger.info(f"Retrying in {delay} seconds...")
                time.sleep(delay)
            else:
                logger.error(f"Failed to send email to {recipient} after {max_retries} attempts.")
                raise e
