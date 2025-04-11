from rest_framework import status
from rest_framework.response import Response
from django.utils import timezone
from api.common.constants import application_message
from django.db.models import Count, Case, When, IntegerField, Count, Q, Value
from django.db.models.functions import Coalesce


from api.common.enums import *
from api.models import User, Applications, Mentors, Students
from api.serializers import CreateApplicationSerializer, ApplicationSerializer2
from api.common.utils import *
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
    def get(self, cohort_id):
        try:
            users = Applications.objects.filter(cohort_id = cohort_id)
            users_serializer = ApplicationSerializer2(users, many=True)
            return Response(users_serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR) 

class GetAllApplicationsWithPagination:
    def get(self, cohort_id, page_number=1, page_size=40):
        try:
            counts = Applications.objects.filter(cohort_id=cohort_id).aggregate(
                mentors_count=Coalesce(Count(Case(
                    When(role=ROLE.MENTOR.value, then=1),
                    output_field=IntegerField(),
                )), 0),
                students_count=Coalesce(Count(Case(
                    When(role=ROLE.STUDENT.value, then=1),
                    output_field=IntegerField(),
                )), 0),
            )

            mentors_count = counts['mentors_count']
            students_count = counts['students_count']

            mentors_page_size = (page_size + 1) // 2 if mentors_count >= students_count else page_size // 2
            students_page_size = page_size - mentors_page_size

            combined_query = Applications.objects.filter(
                Q(cohort_id=cohort_id) & (Q(role=ROLE.MENTOR.value) | Q(role=ROLE.STUDENT.value))
            ).annotate(
                is_mentor=Case(
                    When(role=ROLE.MENTOR.value, then=Value(1)),
                    default=Value(0),
                    output_field=IntegerField()
                )
            ).order_by('submission_date')

            mentors = combined_query.filter(is_mentor=1)[
                (page_number - 1) * mentors_page_size: page_number * mentors_page_size
            ]
            students = combined_query.filter(is_mentor=0)[
                (page_number - 1) * students_page_size: page_number * students_page_size
            ]

            users = list(mentors) + list(students)

            users_serializer = ApplicationSerializer2(users, many=True)

            total_mentors_pages = (mentors_count // mentors_page_size) + (1 if mentors_count % mentors_page_size != 0 else 0)

            total_students_pages = (students_count // students_page_size) + (1 if students_count % students_page_size != 0 else 0)

            total_pages = max(total_mentors_pages, total_students_pages)

            return Response({
                "current_page": page_number,
                "total_pages": total_pages,
                "data": users_serializer.data
            }, status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong 🤔"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR
            )



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
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class ReviewApplication:
    def review(self, data, applicant_id):
        try:
            application = Applications.objects.select_related('user').get(applicant_id=applicant_id)

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
                    if Applications.objects.filter(role=ROLE.MENTOR.value, status=APPLICATION_STATUS.PENDING.value, cohort=application.cohort).exists():
                        return Response(
                            data={"message": "All mentor applications must be reviewed before student applications \U0001F9D0"},
                            status=status.HTTP_400_BAD_REQUEST)
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
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

    def create_mentor(self, application):
        user = application.user
        track = application.track
        new_mentor = Mentors.objects.create(user=user, track=track)
        new_mentor.save()

        password = None
        isPreviousMentor =  Mentors.objects.filter(user=user).exists()
        if not isPreviousMentor:
            password = self.set_mentor_password(user)

        logger.info(f"Added a new mentor to the track: {track.track_id} with email: {user.email} and password: {password}")
        message = application_message(application, password, isPreviousMentor)
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
        isPreviouslyAccepted = Students.objects.filter(user=user).exists()
        logger.info(f"Added a new student to the track: {track.track_id} with email: {user.email} and password: {user.phone_number}")
        message = application_message(application, user.phone_number, isPreviouslyAccepted)
        sendEmail(user.email, message['subject'], message['body'])

    def select_mentor(self, track):
        mentor = Mentors.objects.annotate(num_mentees=Count('mentees')).filter(track=track).order_by('num_mentees').first()
        return mentor

    def update_track(self, track):
        track.enrolled_count += 1
        track.save()

class GetApplicationStats:
    def get(self, cohort_id):
        try:
            applications = Applications.objects.filter(cohort_id=cohort_id)
            stats = {
                "cohort_id": cohort_id,
                "number_of_interns": applications.filter(role=ROLE.STUDENT.value).count(),
                "number_of_mentors": applications.filter(role=ROLE.MENTOR.value).count(),
                "number_of_male_interns": applications.filter(role=ROLE.STUDENT.value, user__gender = GENDER.MALE.value).count(),
                "number_of_female_interns": applications.filter(role=ROLE.STUDENT.value, user__gender = GENDER.FEMALE.value).count(),
                "number_of_male_mentors": applications.filter(role=ROLE.MENTOR.value, user__gender = GENDER.MALE.value).count(),
                "number_of_female_mentors": applications.filter(role=ROLE.MENTOR.value, user__gender = GENDER.FEMALE.value).count()
            }
            return Response(stats, status=status.HTTP_200_OK)
        except Applications.DoesNotExist:
            return Response(
                data={"message": "Cohort with id: {} does not exist \U0001F636".format(
                    cohort_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)