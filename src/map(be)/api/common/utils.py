from django.core.mail import send_mail
from django.conf import settings


def sendEmail(recipient, subject, message):
    sender = settings.EMAIL_HOST_USER
    send_mail(subject, message, sender, [recipient], fail_silently=False)
