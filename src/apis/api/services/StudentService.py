from rest_framework import status
from rest_framework.response import Response
from ..models import User, Students, Track, Mentors
from ..serializers import TrackSerializer_C, GetStudentSerializer, GetLatestTrackSerializer
from ..common.enums import *
from django.utils import timezone
import logging

logger = logging.getLogger(__name__)

class GetStudent:
    def get(self, user_id):
        try:
            track_id = GetLatestTrack().get(user_id).data['track']
            if track_id == None:
                return Response(
                    data={"message": "This student does not have a track \U0001F9D0"},
                    status=status.HTTP_404_NOT_FOUND,
                )
            student = Students.objects.get(user_id=user_id, track_id=track_id)
            student_serializer = GetStudentSerializer(student)
            return Response(student_serializer.data, status=status.HTTP_200_OK)
        except Students.DoesNotExist:
            return Response(
                data={"message": "This student does not exist \U0001F9D0"},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        
    def get_with_track(self, user_id, track_id):
        try:
            student = Students.objects.get(user_id=user_id, track_id=track_id)
            student_serializer = GetStudentSerializer(student)
            return Response(student_serializer.data, status=status.HTTP_200_OK)
        except Students.DoesNotExist:
            return Response(
                data={"message": "This student does not exist \U0001F9D0"},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        

class GetLatestTrack:
    def get(self, user_id):
        try:
            user = User.objects.get(user_id=user_id)
            latest_track = Track.objects.filter(students__user=user, cohort__start_date__lt=timezone.now()).order_by('-cohort__start_date').first()
            latest_track_serializer = GetLatestTrackSerializer(latest_track)
            if latest_track:
                return Response(
                    data={"message": "Latest track found for this user \U0001F9D0", "track": latest_track_serializer.data['track_id']},
                    status=status.HTTP_200_OK
                    )
            return Response(
                data={"message": "No track found for this user, He/She might not be a student yet \U0001F9D0", "track": None},
                status=status.HTTP_404_NOT_FOUND,
            )
        except User.DoesNotExist:
            return Response(
                data={"message": "User with id: {} does not exist".format(user_id), "track":None},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0", "track": None},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )

class GetLatestCohortForStudent:
    def get(self, user_id):
        try:
            user = User.objects.get(user_id=user_id)
            latest_track = Track.objects.filter(students__user=user, cohort__start_date__lt=timezone.now()).order_by('-cohort__start_date').first()
            latest_track_serialier = GetLatestTrackSerializer(latest_track.cohort)
            if latest_track:
                return Response(latest_track_serialier, status=status.HTTP_200_OK)
            return Response(
                data={"message": "No track found for this user, He/She might not be a student yet \U0001F9D0"},
                status=status.HTTP_404_NOT_FOUND,
            )
        except User.DoesNotExist:
            return Response(
                data={"message": "User with id: {} does not exist".format(user_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        
class TrackCourseSerializer:
    def get(self, user_id, track_id):
        try:
            track = Track.objects.get(track_id=track_id)
            track_serializer = GetLatestTrackSerializer(track)
            return Response(track_serializer.data, status=status.HTTP_200_OK)
        except Track.DoesNotExist:
            return Response(
                data={"message": "Track with id: {} does not exist".format(track_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        

class GetStudentTrackCourses:
    def get(self, user_id, track_id):
        try:
            user = User.objects.get(user_id=user_id)
            track = Track.objects.get(students__user=user, track_id=track_id)
            track_serializer = TrackSerializer_C(track, user_id=user_id)
            return Response(track_serializer.data, status=status.HTTP_200_OK)
        except Track.DoesNotExist:
            return Response(
                data={"message": "Track with id: {} does not exist".format(track_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except User.DoesNotExist:
            return Response(
                data={"message": "User with id: {} does not exist".format(user_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        
class ChangeStudentMentor:
    def put(self, request):
        try:
            user_id = request.data.get('student_id')
            track_id = request.data.get('track_id')
            mentor_id = request.data.get('mentor_id')
            student = Students.objects.get(user_id=user_id, track_id=track_id)
            mentor = Mentors.objects.get(user_id=mentor_id, track_id=track_id)

            student.mentor = mentor
            student.save()
            return Response(
                data={"message": "Mentor changed successfully \U0001F607"},
                status=status.HTTP_200_OK,
            )
        except Students.DoesNotExist:
            return Response(
                data={"message": "Student with id: {} does not exist or not registered in this cohort \U0001F9D0".format(user_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Mentors.DoesNotExist:
            return Response(
                data={"message": "Mentor with id: {} does not exist or not registered in this cohort \U0001F9D0".format(mentor_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
