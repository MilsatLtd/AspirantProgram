from rest_framework import status
from rest_framework.response import Response
from ..models import Report, Mentors
from ..serializers import ReportSerializer
from django.utils import timezone



class CreateReportService:
    def create_report(self, request):
        serializer = ReportSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    
class ListReportService:
    def get(self, request):
        reports = Report.objects.all()
        serializer = ReportSerializer(reports, many=True)
        return Response(serializer.data, status=status.HTTP_200_OK)
    

class GetReportByReportIdService:
    def get(self, request, report_id):
        try:
            report = Report.objects.get(report_id=report_id)
            serializer = ReportSerializer(report)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Report.DoesNotExist:
            return Response(
                data={"message": "Report with id: {} does not exist \U0001F9D0".format(report_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        
class ListStudentReportService:
    def get(self, request, student_id):
        from .CohortService import GetLatestCohort
        try:
            latest_cohort = GetLatestCohort().get_student(student_id)
            reports = Report.objects.filter(student_id=student_id, cohort=latest_cohort)
            serializer = ReportSerializer(reports, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Report.DoesNotExist:
            return Response(
                data={"message": "This student does not have any report \U0001F9D0"},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            print(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        
class ReportFeedbackService:
    def post(self, request, report_id):
        try:
            report = Report.objects.get(report_id=report_id)
            mentor = Mentors.objects.get(user__user_id=request.data.get('mentor_id'))
            if not report.student not in mentor.mentees.all():
                return Response(
                    data={"message": "This mentor is not assigned to this student \U0001F9D0"},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            # check if report feedback is already given
            if report.mentor_feedback:
                return Response(
                    data={"message": "Feedback for this report is already given \U0001F9D0"},
                    status=status.HTTP_400_BAD_REQUEST,
                )
            report.mentor_feedback = request.data.get('mentor_feedback')
            serializer = ReportSerializer(instance=report, data=request.data, partial=True)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_200_OK)
            return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
        except Report.DoesNotExist:
            return Response(
                data={"message": "Report with id: {} does not exist".format(report_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Mentors.DoesNotExist:
            return Response(
                data={"message": "Mentor with id: {} does not exist".format(request.data['mentor_id'])},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            print(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
        

class ListMentorReportService:
    # list all reports submitted to a mentor for the latest cohort
    def get(self, request, mentor_id):
        from .CohortService import GetLatestCohort
        try:
            latest_track = GetLatestCohort().get_mentor(mentor_id, track= True)
            mentor = Mentors.objects.get(user__user_id=mentor_id, track=latest_track)
            students = mentor.mentees.all().values_list('user', flat=True)
            mentor_reports = Report.objects.filter(student__in=students)
            serializer = ReportSerializer(mentor_reports, many=True)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Report.DoesNotExist:
            return Response(
                data={"message": "This mentor does not have any report \U0001F9D0"},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            print(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )