from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView, UpdateAPIView, DestroyAPIView, GenericAPIView
from ..serializers import *
from ..services.StudentService import *
from drf_yasg.utils import swagger_auto_schema
from rest_framework import mixins
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin


class GetStudentByLatestTrackView(RetrieveAPIView):
    serializer_class = GetStudentSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema( operation_summary="Get a student by user_id. This returns the latest track of the student.")
    def get(self, request, user_id):
        return GetStudent().get(user_id)

    
class GetStudentView(RetrieveAPIView):
    serializer_class = GetStudentSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema( operation_summary="Get a student by user_id and track_id.")
    def get(self, request, user_id, track_id):
        return GetStudent().get_with_track(user_id, track_id)
    

class GetStudentLatestTrackView(RetrieveAPIView):
    serializer_class = GetLatestTrackSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema( operation_summary="Get the latest track of a student by user_id")
    def get(self, request, user_id):
        return GetLatestTrack().get(user_id)
    
class GetStudentTrackCoursesView(RetrieveAPIView):
    serializer_class = TrackSerializer_C
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema( operation_summary="Get the courses of a student by user_id and track_id")
    def get(self, request, student_id, track_id):
        return GetStudentTrackCourses().get(student_id, track_id)
    

class ChangeStudentMentorView(mixins.UpdateModelMixin, GenericAPIView):
    serializer_class = ChangeMentorSerializer
    permission_classes = (IsAuthenticated, IsAdmin,)

    @swagger_auto_schema( operation_summary="Change the mentor of a student by user_id")
    def put(self, request):
        return ChangeStudentMentor().put(request)