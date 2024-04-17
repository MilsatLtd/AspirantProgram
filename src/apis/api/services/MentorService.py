from rest_framework import status
from rest_framework.response import Response
from ..models import User, Mentors, Track
from ..serializers import UserSerializer, MentorSerializer, GetLatestTrackSerializer, GetMentorSerializer
from django.utils import timezone
import logging

logger = logging.getLogger(__name__)

class GetMentor:
    def get(self, user_id):
        try:
            track_id = GetLatestTrack().get(user_id).data['track']
            if track_id == None:
                return Response(
                    data={"message": "This mentor does not have a track \U0001F9D0"},
                    status=status.HTTP_404_NOT_FOUND,
                )
            mentor = Mentors.objects.get(user_id=user_id, track_id=track_id)
            mentor_serializer = GetMentorSerializer(mentor)
            return Response(mentor_serializer.data, status=status.HTTP_200_OK)
        except Mentors.DoesNotExist:
            return Response(
                data={"message": "This mentor does not exist \U0001F9D0"},
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
            mentor = Mentors.objects.get(user_id=user_id, track_id=track_id)
            mentor_serializer = GetMentorSerializer(mentor)
            return Response(mentor_serializer.data, status=status.HTTP_200_OK)
        except Mentors.DoesNotExist:
            return Response(
                data={"message": "This mentor does not exist \U0001F9D0"},
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
            latest_track = Track.objects.filter(mentors__user=user, cohort__start_date__lt=timezone.now()).order_by('-cohort__start_date').first()
            latest_track_serializer = GetLatestTrackSerializer(latest_track)
            if latest_track:
                return Response(
                    data={"message": "Latest track found for this user \U0001F9D0", "track": latest_track_serializer.data['track_id']},
                    status=status.HTTP_200_OK
                    )
            return Response(
                data={"message": "No track found for this user, He/She might not be a mentor yet \U0001F9D0", "track": None},
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


