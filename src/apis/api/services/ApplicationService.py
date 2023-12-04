from rest_framework import status
from rest_framework.response import Response
from django.utils import timezone
from api.common.constants import application_message

from api.common.enums import *
from api.models import User, Applications, Mentors, Students
from api.serializers import UserSerializer, ApplicationSerializer, CreateApplicationSerializer, ApplicationSerializer2
from api.common.utils import sendEmail
import logging

logger = logging.getLogger(__name__)


class ApplytoLiveCohort:
    # create user and application with empty bio field
    def apply(self, data):
        try:
            ser = CreateApplicationSerializer(data=data)
            if ser.is_valid():
                ser.save()
                return Response(ser.data, status=status.HTTP_201_CREATED)
            return Response(ser.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetAllApplications:
    def get(self):
        try:
            users = Applications.objects.all()
            users_serializer = ApplicationSerializer2(users, many=True)
            return Response(users_serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetApplicationById:
    def __init__(self, applicant_id):
        self.user_id = applicant_id
    # get user and application by user_id

    def get(self):
        try:
            user = Applications.objects.get(user_id=self.user_id)
            user_serializer = ApplicationSerializer2(user)
            return Response(user_serializer.data, status=status.HTTP_200_OK)
        except User.DoesNotExist:
            return Response(
                data={"message": "User with id: {} does not exist \U0001F9D0".format(
                    self.user_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class ReviewApplication:
    def review(self, data, applicant_id):
        try:
            application = Applications.objects.select_related(
                'user').get(applicant_id=applicant_id)
            if application.status != APPLICATION_STATUS.PENDING.value:
                return Response(
                    data={"message": "Application with id: {} has already been reviewed \U0001F9D0".format(
                        applicant_id)},
                    status=status.HTTP_400_BAD_REQUEST)
            application.status = data["status"]
            application.review_date = timezone.now()
            if data["status"] == APPLICATION_STATUS.ACCEPTED.value:
                user = application.user
                if application.role == ROLE.MENTOR.value:
                    self.create_mentor(application)
                elif application.role == ROLE.STUDENT.value:
                    self.create_student(application)
            application.save()
            self.update_track(application.track)
            return Response(
                data={"message": "Application status updated successfully \U0001F4AF"},
                status=status.HTTP_200_OK)
        except Applications.DoesNotExist:
            return Response(
                data={"message": "Application with id: {} does not exist \U0001F636".format(
                    applicant_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            print(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def create_mentor(self, application):
        user = application.user
        track = application.track
        new_mentor = Mentors.objects.create(user=user, track=track)
        password = self.set_mentor_password(user)
        new_mentor.save()
        message = application_message(application, password)
        sendEmail(user.email, message['subject'], message['body'])

    def set_mentor_password(self, user):
        password = self.generate_mentor_password()
        print("Mentor password -", password)
        user.set_password2(password)
        user.save()
        return password

    def generate_mentor_password(self, length=6):
        import random
        import string
        letters = string.digits
        result_str = ''.join(random.choice(letters) for i in range(length))
        return result_str

    def create_student(self, application):
        user = application.user
        track = application.track
        new_student = Students.objects.create(user=user, track=track)
        new_student.mentor = self.select_mentor(track)
        new_student.save()
        message = application_message(application, user.phone_number)
        sendEmail(user.email, message['subject'], message['body'])

    def select_mentor(self, track):
        mentor = Mentors.objects.filter(
            track=track).order_by('mentees').first()
        return mentor

    def update_track(self, track):
        track.enrolled_count += 1
        track.save()
