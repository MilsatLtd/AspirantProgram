from rest_framework.decorators import api_view
from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status, mixins, viewsets
from .models import *
from .serializers import *
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView, UpdateAPIView, DestroyAPIView

from .services.StudentService import *
from .services.MentorService import *
from .services.UserService import *
from .services.CohortService import *
from .services.TrackService import *
from .services.ApplicationService import *

class CreateandListUser(CreateAPIView):
    serializer_class = UserSerializer

    def get(self, request):
        return GetAllUsersService().get()

    def post(self, request):
        try:
            if request.data['role'] == 1:
                service = CreateMentor(request.data)
                return service.create()
            if request.data['role'] == 2:
                service = CreateStudent(request.data)
                return service.create()
        except Exception as e:
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        

class GetUser(RetrieveAPIView):
    serializer_class = UserSerializer
    queryset = User.objects.all()

    def get(self, request, user_id):
        return GetUserByIdService(user_id).get()

class CreateandListApplication(CreateAPIView):
    serializer_class = CreateApplicationSerializer

    def get(self, request):
        return GetAllApplications().get()
    
    def post(self, request):
        return CreateApplication(request.data).create()
    
class GetApplication(RetrieveAPIView):
    serializer_class = ApplicationSerializer

    def get(self, applicant_id):
        return GetApplicationById(applicant_id).get()