from rest_framework.response import Response
from rest_framework import status
from rest_framework.generics import CreateAPIView, ListAPIView, RetrieveAPIView, UpdateAPIView, DestroyAPIView, GenericAPIView
from ..serializers import *
from drf_yasg.utils import swagger_auto_schema
from rest_framework import mixins
from ..services.TodoService import *
from rest_framework.parsers import MultiPartParser, FormParser
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin


class SubmitTodoView(CreateAPIView):
    serializer_class = SubmitTodoSerializer
    parser_classes = [MultiPartParser, FormParser]
    permission_classes = (IsAuthenticated, IsMentee,)

    @swagger_auto_schema(operation_summary="Submit a todo",
                         )
    def post(self, request):
        return SubmitTodoService().create(request)


class GetTodoView(RetrieveAPIView):
    serializer_class = TodoSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema(operation_summary="Get a todo by todo_id")
    def get(self, request, todo_id):
        return GetTodoByIdService().get(request, todo_id)


class ReviewTodoView(mixins.UpdateModelMixin, GenericAPIView):
    # serializer_class = ReviewTodoSerializer

    # @swagger_auto_schema( operation_summary="Review todo by assigned mentor ")
    def put(self, request, todo_id):
        pass
