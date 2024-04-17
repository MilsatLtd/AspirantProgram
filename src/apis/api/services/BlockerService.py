from rest_framework import status
from rest_framework.response import Response
from django.utils import timezone
from api.common.constants import application_message

from api.common.enums import *
from api.models import Blocker, Comment
from api.serializers import BlockerSerializer, CommentSerializer
from api.common.utils import sendEmail
import logging

logger = logging.getLogger(__name__)

class GetBlockerByTrack:
    def get(self, request, track_id):
        try:
            blockers = Blocker.objects.filter(track_id=track_id)
            blockers_serializer = BlockerSerializer(blockers, many=True)
            return Response(blockers_serializer.data, status=status.HTTP_200_OK)
        except Exception as e:
            logger.exception(e)
            return Response(
                data={"message": "Something went wrong \U0001F9D0"},
                status=status.HTTP_500_INTERNAL_SERVER_ERROR)
