from rest_framework import status
from rest_framework.response import Response
from ..models import Todo
from ..serializers import TodoSerializer, SubmitTodoSerializer
from django.utils import timezone
from ..common.enums import *
import logging

logger = logging.getLogger(__name__)


class SubmitTodoService:
    def create(self, request):
        # check todo for the course by the student exists
        try:
            serializer = SubmitTodoSerializer(data=request.data)
            if serializer.is_valid():
                serializer.save()
                return Response(serializer.data, status=status.HTTP_201_CREATED)
            return Response(
                serializer.errors, status=status.HTTP_400_BAD_REQUEST
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )


class GetTodoByIdService:
    def get(self, request, todo_id):
        try:
            todo = Todo.objects.get(todo_id=todo_id)
            serializer = TodoSerializer(todo)
            return Response(serializer.data, status=status.HTTP_200_OK)
        except Todo.DoesNotExist:
            return Response(
                data={
                    "message": "Todo with id: {} does not exist \U0001F636".format(todo_id)},
                status=status.HTTP_404_NOT_FOUND,
            )
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR,
            )
