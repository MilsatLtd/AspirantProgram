from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView, UpdateAPIView, DestroyAPIView, GenericAPIView
from ..serializers import *
from ..services.ApplicationService import *
from ..services.CohortService import GetOpenCohort
from drf_yasg.utils import swagger_auto_schema
from rest_framework import mixins
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin



class ListApplication(ListAPIView):
    serializer_class = ApplicationSerializer2
    permission_classes = (IsAuthenticated, IsAdmin,)

    @swagger_auto_schema( operation_summary="List all applications")
    def get(self, request):
        return GetAllApplications().get()
            
class ReviewApplicationView(CreateAPIView):
    serializer_class = ReviewApplicationSerializer
    permission_classes = (IsAuthenticated, IsAdmin,)

    @swagger_auto_schema( operation_summary="Review an application")
    def post(self, request, applicant_id):
        return ReviewApplication().review(request.data, applicant_id)
        
class GetOpenApplyCohortView(RetrieveAPIView):
    serializer_class = OpenCohortSerializer

    @swagger_auto_schema( operation_summary="Get the cohorts that are receiving applications")
    def get(self, request):
        return GetOpenCohort().get()