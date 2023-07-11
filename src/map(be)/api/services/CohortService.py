from rest_framework import status
from rest_framework.response import Response
from api.models import Cohort, User, Track
from api.serializers import CohortSerializer, CreateCohortSerializer, OpenCohortSerializer
from django.utils import timezone
from ..common.utils import sendEmail
from django.core.exceptions import ValidationError
import logging

logger = logging.getLogger(__name__)


class CreateCohort:
    def __init__(self, data):
        self.data = data

    def create(self):
        try:
            cohort_serializer = CreateCohortSerializer(data=self.data)
            if cohort_serializer.is_valid():
                cohort_serializer.save()
                return Response(cohort_serializer.data, status=status.HTTP_201_CREATED)
            return Response(
                data={"message": "Invalid data for cohort creation \U0001F9D0" , "errors": cohort_serializer.errors},
                status=status.HTTP_400_BAD_REQUEST)
        except ValidationError as e:
            res = {
                "message": "Invalid data for cohort creation \U0001F9D0",
                "errors": e.detail
            }
            return Response(
                res, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetCohortById:
    def __init__(self, cohort_id):
        self.cohort_id = cohort_id

    def get(self):
        try:
            cohort = Cohort.objects.get(cohort_id=self.cohort_id)
            cohort_serializer = OpenCohortSerializer(cohort)
            return Response(cohort_serializer.data, status=status.HTTP_200_OK)
        except Cohort.DoesNotExist:
            return Response(
                data={"message": "Cohort with id: {} does not exist \U0001F9D0".format(
                    self.cohort_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetAllCohorts:
    def get(self):
        try:
            cohorts = Cohort.objects.all()
            cohorts_serializer = OpenCohortSerializer(cohorts, many=True)
            return Response(cohorts_serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class UpdateCohort:
    def update(self, cohort_id, data):
        try:
            cohort = Cohort.objects.get(cohort_id=cohort_id)
            cohort_serializer = CohortSerializer(
                cohort, data=data, partial=True)
            if cohort_serializer.is_valid():
                cohort_serializer.update()
                return Response(cohort_serializer.data, status=status.HTTP_200_OK)
            return Response(cohort_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Cohort.DoesNotExist:
            return Response(
                data={"message": "Cohort with id: {} does not exist \U0001F9D0".format(
                    self.cohort_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetOpenCohort:
    def get(self):
        try:
            cohort = Cohort.objects.filter(
                apply_start_date__lte=timezone.now(), apply_end_date__gte=timezone.now())
            cohort_serializer = OpenCohortSerializer(cohort, many=True)
            return Response(cohort_serializer.data, status=status.HTTP_200_OK)
        except Cohort.DoesNotExist:
            return Response(
                data={"message": "No open cohort exists \U0001F9D0"},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetLatestCohort:
    def get_student(self, user_id, track=False):
        try:
            # user = User.objects.get(user_id=user_id)
            latest_track = Track.objects.filter(
                students__user__user_id=user_id, cohort__start_date__lt=timezone.now()).order_by('-cohort__start_date').first()
            if latest_track:
                if track:
                    return latest_track
                return latest_track.cohort
            return None
        except User.DoesNotExist:
            return None
        except Exception as e:
            logger.exception(e)
            return None

    def get_mentor(self, user_id, track=False):
        try:
            latest_track = Track.objects.filter(
                mentors__user__user_id=user_id, cohort__start_date__lt=timezone.now()).order_by('-cohort__start_date').first()
            if latest_track:
                if track:
                    return latest_track
                return latest_track.cohort
            return None
        except User.DoesNotExist:
            return None
        except Exception as e:
            logger.exception(e)
            return None
