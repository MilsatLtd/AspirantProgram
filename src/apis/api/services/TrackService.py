from rest_framework import status
from rest_framework.response import Response
from api.models import Track, Course
from api.serializers import TrackSerializer, TrackSerializer_C, TrackSerializerAnonymous, CourseSerializer, AddCourseToTrackSerializer
import logging
from api.backends.map_permissions import get_claim
from api.common.enums import *


logger = logging.getLogger(__name__)


class CreateTrack:
    def __init__(self, data):
        self.data = data

    def create(self):
        try:
            track_serializer = TrackSerializer(data=self.data)
            if track_serializer.is_valid():
                track_serializer.save()
                return Response(track_serializer.data, status=status.HTTP_201_CREATED)
            return Response(track_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetTrackById:
    def __init__(self, track_id):
        self.track_id = track_id

    def get(self):
        try:
            track = Track.objects.get(track_id=self.track_id)
            track_serializer = TrackSerializer(track)
            return Response(track_serializer.data, status=status.HTTP_200_OK)
        except Track.DoesNotExist:
            return Response(
                data={"message": "Track with id: {} does not exist \U0001F636".format(
                    self.track_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetTrackByCohort:
    def get(self, request, cohort_id):
        try:
            # get all tracks for a particular cohort
            tracks = Track.objects.filter(cohort_id=cohort_id)
            if get_claim(request)['role'] != ROLE.ADMIN.value:
                track_serializer = TrackSerializerAnonymous(tracks, many=True)
            else:
                track_serializer = TrackSerializer(tracks, many=True)
            return Response(track_serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class GetAllTracks:
    def get(self, request):
        try:
            
            tracks = Track.objects.filter(cohort_id=None)
            if get_claim(request)['role'] != ROLE.ADMIN.value:
                tracks_serializer = TrackSerializerAnonymous(tracks, many=True)
            else:
                tracks_serializer = TrackSerializer(tracks, many=True)
            return Response(tracks_serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class UpdateTrack:
    def update(self, track_id, data):
        try:
            track = Track.objects.get(track_id=track_id)
            track_serializer = TrackSerializer(instance=track, data=data)
            if track_serializer.is_valid():
                track_serializer.update( track, data )
                return Response(track_serializer.data, status=status.HTTP_200_OK)
            return Response(track_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Track.DoesNotExist:
            return Response(
                data={
                    "message": "Track with id: {} does not exist \U0001F636".format(track_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

class AddCourseToTrack:
    def __init__(self, data):
        self.data = data

    def add_course(self):
        try:            
            course_serializer = AddCourseToTrackSerializer(data=self.data)
            if course_serializer.is_valid():
                course_serializer.save()
                return Response(course_serializer.data, status=status.HTTP_200_OK)
            return Response(course_serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Track.DoesNotExist as e:
            return Response(
                data={
                    "message": "Track with id: {} does not exist \U0001F636".format(
                        self.track_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)


class DeleteTrack:
    def __init__(self, track_id):
        self.track_id = track_id

    def delete(self):
        try:
            track = Track.objects.get(track_id=self.track_id)
            track.delete()
            return Response(
                data={"message": "Track with id: {} deleted successfully \U0001F44D".format(
                    self.track_id)},
                status=status.HTTP_200_OK)
        except Track.DoesNotExist:
            return Response(
                data={
                    "message": "Track with id: {} does not exist \U0001F636".format(
                        self.track_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        

class ReorderTrackCourses:
    def __init__(self, track_id, data):
        self.track_id = track_id
        self.data = data

    def reorder(self):
        try:
            track = Track.objects.get(track_id=self.track_id)
            courses = self.data['courses']
            # ensure the list of courses is the same as the list of courses in the track
            if len(courses) != track.courses.count():
                return Response(
                    data={
                        "message": "The list of courses provided is not the same as the list of courses in the track \U0001F636"},
                    status=status.HTTP_400_BAD_REQUEST)
            for index, course_id in enumerate(courses, 1):
                course = Course.objects.get(course_id=course_id)
                course.order = index
                course.save()
            return Response(
                data={"message": "Courses reordered successfully \U0001F44D"},
                status=status.HTTP_200_OK)
        except Track.DoesNotExist:
            return Response(
                data={
                    "message": "Track with id: {} does not exist \U0001F636".format(
                        self.track_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Course.DoesNotExist:
            return Response(
                data={
                    "message": "Course with id: {} does not exist \U0001F636".format(
                        course_id)},
                status=status.HTTP_404_NOT_FOUND)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)