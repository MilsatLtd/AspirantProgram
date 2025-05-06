from api.tasks import send_html_email_task, send_html_email_task2
from ..models import User, Mentors, Cohort
from ..serializers import UserSerializer, FullUserSerializer
from rest_framework.response import Response
from rest_framework import status
from api.common.enums import *
from api.backends.map_permissions import get_claim, get_role_from_claim
import logging
from django.utils import timezone

logger = logging.getLogger(__name__)


# Create service to get a user by id
class GetUserByIdService:
    def __init__(self, user_id):
        self.pk = user_id

    def get(self):
        try:
            user = User.objects.get(user_id=self.pk)
            serializer = UserSerializer(user)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# Create service to get all users


class GetAllUsersService:
    def get(self):
        try:
            users = User.objects.all()
            serializer = FullUserSerializer(users, many=True)
            return Response(serializer.data)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

# Create service to update a user by id


class UpdateUserByIdService:
    def update(self, request, pk):
        try:
            user = User.objects.get(user_id=pk)

            if 'class_url' in request.data:
                if not self.is_mentor_in_latest_active_cohort(pk):
                    return Response(
                        data={"message": "Only mentors in an active cohort can update the class URL."},
                        status=status.HTTP_403_FORBIDDEN)

            serializer = UserSerializer(user, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except User.DoesNotExist:
             return Response(
                data={"message": "User not found."},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        

    def is_mentor_in_latest_active_cohort(self, user_id):
        """
        Checks if a user is a mentor in the latest currently active cohort.
        """
        now = timezone.now()
        latest_active_cohort = Cohort.objects.filter(
            end_date__gte=now
        ).order_by('-start_date').first()

        if not latest_active_cohort:
            return False

        is_mentor = Mentors.objects.filter(
            user__user_id=user_id,
            track__cohort=latest_active_cohort
        ).exists()

        return is_mentor


# Create service to delete a user by id
class DeleteUserByIdService:
    def __init__(self, pk):
        self.pk = pk

    def delete(self):
        try:
            user = User.objects.get(user_id=self.pk)
            user.delete()
            return True
        except Exception as e:
            logger.exception(e)
            return e


class UpdateUserPicture:
    def update(self, request, pk):
        try:
            user = User.objects.get(user_id=pk)
            serializer = FullUserSerializer(
                user, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_200_OK)
            else:
                return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class ChangePassword:
    def update(self, request):
        try:
            if request.data['new_password'] != request.data['new_password_confirm']:
                return Response(
                    data={"message": "Passwords do not match \U0001F9D0"},
                    status=status.HTTP_400_BAD_REQUEST)

            if request.data['new_password'] == request.data['old_password']:
                return Response(
                    data={
                        "message": "New password cannot be the same as old password \U0001F9D0"},
                    status=status.HTTP_400_BAD_REQUEST)
            
            user, profile = request.user, get_role_from_claim(request)

            isPassword, passwordProfile = user.check_password(request.data['old_password'])
            if not isPassword:
                return Response(
                    data={"message": "Old password is incorrect \U0001F9D0"},
                    status=status.HTTP_400_BAD_REQUEST)
            
            if profile != passwordProfile:
                return Response(
                    data={"message": "You can't change password for another profile, sign in with that profile \U0001F9D0"},
                    status=status.HTTP_400_BAD_REQUEST)
            
            if user.check_password(request.data['new_password'])[0]:
                return Response(
                    data={
                        "message": "You can't use the same password for your intern and mentor profile \U0001F9D0"},
                    status=status.HTTP_400_BAD_REQUEST)
            
            if profile == ROLE.MENTOR.value:
                user.set_password2(request.data['new_password'])

            elif profile == ROLE.STUDENT.value:
                user.set_password(request.data['new_password'])

            user.save()
            return Response(
                data={"message": "Password changed successfully \U0001F44D"},
                status=status.HTTP_200_OK)

        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class SendAnyEmailService:
    def send(self, request):
        try:
            # send email from html template to any recipient
            send_html_email_task(
                subject=request.data['subject'],
                recipient=[request.data['email']],
                message=request.data['message'],
            )
            return Response(
                data={"message": "Email scheduled successfully \U0001F44D"},
                status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class SendAnyEmailService2:
    def send(self, request):
        try:
            # send email from html template to any recipient
            send_html_email_task2.delay(
                request.data['subject'],
                [request.data['email']],
                request.data['message'],
            )
            return Response(
                data={"message": "Email scheduled successfully \U0001F44D"},
                status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)
