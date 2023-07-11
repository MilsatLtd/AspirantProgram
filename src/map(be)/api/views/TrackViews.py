from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView, UpdateAPIView, DestroyAPIView, GenericAPIView
from ..serializers import *
from ..services.TrackService import *
from drf_yasg.utils import swagger_auto_schema
from rest_framework import mixins
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin

class CreateandListTrack(CreateAPIView):
    serializer_class = TrackSerializer
    permission_classes = (IsAuthenticated,)

    def get_permissions(self):
        if self.request.method == 'POST':
            self.permission_classes = (IsAuthenticated, IsAdmin,)
        return super().get_permissions()


    @swagger_auto_schema( operation_summary="Get all the administrative main tracks")
    def get(self, request):
        return GetAllTracks().get(request)

    @swagger_auto_schema( operation_summary="Add a new track")
    def post(self, request):
        return CreateTrack(request.data).create()
    
class GetTrackByCohortView(RetrieveAPIView):
    serializer_class = TrackSerializer
    permission_classes = (IsAuthenticated,)

    # add swagger description of this endpoiny
    @swagger_auto_schema( operation_summary="Get all tracks for a particular cohort")
    def get(self, request, cohort_id):
        return GetTrackByCohort().get(request, cohort_id)
    
    
class GetAndUpdateTrackView(mixins.RetrieveModelMixin,
                            mixins.UpdateModelMixin,
                            GenericAPIView):
    serializer_class = TrackSerializer

    def get_permissions(self):
        if self.request.method == 'PUT':
            self.permission_classes = (IsAuthenticated, IsAdmin)
        else:
            self.permission_classes = (IsAuthenticated,)
        return super().get_permissions()

    @swagger_auto_schema( operation_summary="Get a track by its id")
    def get(self, request, track_id):
        return GetTrackById(track_id).get()
    
    @swagger_auto_schema( operation_summary="Update a track by its id")
    def put(self, request, track_id):
        return UpdateTrack().update(track_id, request.data)