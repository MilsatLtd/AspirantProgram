from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView, UpdateAPIView, DestroyAPIView, GenericAPIView
from ..serializers import *
from ..services.CohortService import *
from ..services.ApplicationService import *
from drf_yasg.utils import swagger_auto_schema
from rest_framework import mixins
from rest_framework.permissions import IsAuthenticated
from rest_framework.parsers import MultiPartParser, FormParser
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin


class CreateandListCohort(CreateAPIView):
    def get_permissions(self):
        if self.request.method == 'POST':
            self.permission_classes = (IsAuthenticated, IsAdmin)
        else:
            self.permission_classes = (IsAuthenticated,)
        return super().get_permissions()

    def get_serializer_class(self   ):
        if self.request.method == 'GET':
            return OpenCohortSerializer
        return CreateCohortSerializer

    @swagger_auto_schema(operation_summary="Get all the cohorts")
    def get(self, request):
        return GetAllCohorts().get()

    @swagger_auto_schema(operation_summary="Add a new cohort")
    def post(self, request):
        return CreateCohort(request.data).create()


class GetAndUpdateCohortView(mixins.RetrieveModelMixin,
                             mixins.UpdateModelMixin,
                             GenericAPIView):
    serializer_class = CohortSerializer
    def get_permissions(self):
        if self.request.method == 'PUT':
            self.permission_classes = (IsAuthenticated, IsAdmin)
        else:
            self.permission_classes = (IsAuthenticated,)
        return super().get_permissions()

    @swagger_auto_schema(operation_summary="Get a cohort by its cohort_id")
    def get(self, request, cohort_id):
        return GetCohortById(cohort_id).get()

    @swagger_auto_schema(operation_summary="Update a cohort by its cohort_id",
                         request_body=CreateCohortSerializer,
                         responses={200: CohortSerializer})
    def put(self, request, cohort_id):
        return UpdateCohort().update(cohort_id, request.data)


class ApplytoLiveCohortView(CreateAPIView):
    serializer_class = CreateApplicationSerializer
    parser_classes = [MultiPartParser]

    @swagger_auto_schema(operation_summary="Apply to a live cohort")
    def post(self, request):
        return ApplytoLiveCohort().apply(request.data)
