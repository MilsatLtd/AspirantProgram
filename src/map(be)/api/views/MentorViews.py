
from rest_framework.generics import RetrieveAPIView
from ..serializers import *
from ..services.MentorService import *
from drf_yasg.utils import swagger_auto_schema
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsAdmin, IsMentee

class GetMentorByLatestTrackView(RetrieveAPIView):
    serializer_class = GetMentorSerializer
    # permission_classes = (IsAuthenticated|IsMentor, )

    @swagger_auto_schema( operation_summary="Get a mentor by user_id. This returns the latest track of the mentor.")
    def get(self, request, user_id):
        return GetMentor().get(user_id)

class GetMentorView(RetrieveAPIView):
    serializer_class = GetMentorSerializer
    # permission_classes = (IsAuthenticated, IsMentor,)

    @swagger_auto_schema( operation_summary="Get a mentor by user_id and track_id.")
    def get(self, request, user_id, track_id):
        return GetMentor().get_with_track(user_id, track_id)
    

class GetMentorLatestTrackView(RetrieveAPIView):
    serializer_class = GetLatestTrackSerializer
    # permission_classes = (IsAuthenticated, IsMentor,)

    @swagger_auto_schema( operation_summary="Get the latest track of a mentor by user_id")
    def get(self, request, user_id):
        return GetLatestTrack().get(user_id)