from celery import shared_task
from .models import Cohort
from .common.enums import *
import logging

logger = logging.getLogger(__name__)


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
