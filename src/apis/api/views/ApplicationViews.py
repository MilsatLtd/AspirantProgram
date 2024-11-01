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

    @swagger_auto_schema( operation_summary="List all applications for a cohort")
    def get(self, request, cohort_id):
        try:
            page_number = int( request.query_params.get('page_number', 1) )
            page_size = int( request.query_params.get('page_size', 30) )
            return GetAllApplicationsWithPagination().get(cohort_id, page_number, page_size)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)
            
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
    
class GetApplicationStatsView(RetrieveAPIView):
    serializer_class = ApplicationStatsSerializer
    permission_classes = (IsAuthenticated, IsAdmin,)

    @swagger_auto_schema( operation_summary="Get application statistics")
    def get(self, request, cohort_id):
        return GetApplicationStats().get(cohort_id)
    

from django.http import HttpResponse
from django.shortcuts import get_object_or_404
from openpyxl import Workbook
from api.models import Applications

logger = logging.getLogger(__name__)

class ExportApplicationsView(RetrieveAPIView):
    permission_classes = (IsAuthenticated, IsAdmin,)

    # @method_decorator(login_required)
    @swagger_auto_schema( operation_summary="Export applications for a cohort")
    def get(self, request, cohort_id, role):
        try:
            role = role.lower()
            if role not in ['mentor', 'aspirant']:
                return HttpResponse("Invalid role. Must be 'mentor' or 'aspirant'.", status=400)

            cohort = get_object_or_404(Cohort, cohort_id=cohort_id)
            role_value = 1 if role == 'mentor' else 2  # 1 for Mentor, 2 for Student (aspirant)

            applications = Applications.objects.filter(cohort=cohort, role=role_value).select_related('user')

            wb = Workbook()
            ws = wb.active
            ws.title = f"{role.capitalize()} Applications"

            # Write headers
            headers = [
                "User ID", "First Name", "Last Name", "Email", "Gender", "Role", "Country", "Phone Number",
                "Application ID", "Reason", "Referral", "Skills", "Purpose", "Education",
                "Submission Date", "Review Date", "Status"
            ]
            ws.append(headers)

            # Write data
            for app in applications:
                user = app.user
                
                 # Convert datetime fields to timezone-naive objects
                submission_date = app.submission_date.astimezone(timezone.utc).replace(tzinfo=None) if app.submission_date else None
                review_date = app.review_date.astimezone(timezone.utc).replace(tzinfo=None) if app.review_date else None
                
                row = [
                    str(user.user_id), user.first_name, user.last_name, user.email,
                    user.get_gender_display(), app.get_role_display(), user.country, user.phone_number,
                    str(app.applicant_id), app.reason, app.referral, app.skills, app.purpose,
                    app.get_education_display(), submission_date, review_date,
                    app.get_status_display()
                ]
                ws.append(row)

            # Create response
            response = HttpResponse(content_type='application/vnd.openxmlformats-officedocument.spreadsheetml.sheet')
            response['Content-Disposition'] = f'attachment; filename={cohort.name}_{role}_applications.xlsx'
            wb.save(response)

        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)

        return response