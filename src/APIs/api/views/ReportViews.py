
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView, GenericAPIView
from ..serializers import *
from drf_yasg.utils import swagger_auto_schema
from rest_framework import mixins
from ..services.ReportService import *
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin


class GetReportView(RetrieveAPIView):
    serializer_class = ReportSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema( operation_summary="Get a report by report_id")
    def get(self, request, report_id):
        return GetReportByReportIdService().get(request, report_id)

class CreateReportView(CreateAPIView):
    serializer_class = ReportSubmitSerializer
    permission_classes = (IsAuthenticated, IsMentee,)

    @swagger_auto_schema( operation_summary="Submit a report by student_id")
    def post(self, request):
        return CreateReportService().create_report(request)

class SubmitReportView(mixins.UpdateModelMixin, GenericAPIView):
    serializer_class = ReportFeedbackSerializer
    permission_classes = (IsAuthenticated, IsMentor,)

    @swagger_auto_schema( operation_summary="Submit a feedback for a report")
    def put(self, request, report_id):
        return ReportFeedbackService().post(request, report_id)

class ListReportView(ListAPIView):
    serializer_class = ReportSerializer
    permission_classes = (IsAuthenticated, )

    @swagger_auto_schema( operation_summary="List all reports")
    def get(self, request):
        return ListReportService().get(request)
    
class ListStudentReportView(ListAPIView):
    serializer_class = ReportSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema( operation_summary="List all reports by student_id")
    def get(self, request, student_id):
        return ListStudentReportService().get(request, student_id)
    

class ListMentorReportView(ListAPIView):
    serializer_class = ReportSerializer
    permission_classes = (IsAuthenticated, IsMentor, IsAdmin)

    @swagger_auto_schema( operation_summary="List all reports submitted to a mentor")
    def get(self, request, mentor_id):
        return ListMentorReportService().get(request, mentor_id)
    