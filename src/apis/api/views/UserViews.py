from rest_framework.generics import GenericAPIView
from rest_framework.mixins import UpdateModelMixin, RetrieveModelMixin, CreateModelMixin
from drf_yasg.utils import swagger_auto_schema
from ..services.UserService import *
from ..serializers import *
from rest_framework.parsers import MultiPartParser
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin


class UpdateProfileView(RetrieveModelMixin,
                        UpdateModelMixin,
                        GenericAPIView):
    serializer_class = UpdateUserProfileSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema(operation_summary="Update a user's profile by user_id")
    def put(self, request, user_id):
        # ensure only a user can update his profile
        if request.user.user_id != user_id:
            return Response(
                data={
                    "message": "Only the user can update his/her profile"
                },
                status=status.HTTP_401_UNAUTHORIZED
            )
        return UpdateUserByIdService().update(request, user_id)


class UpdateProfilePictureView(RetrieveModelMixin,
                               UpdateModelMixin,
                               GenericAPIView):
    serializer_class = UpdateProfilePictureSerializer
    parser_classes = [MultiPartParser]
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema(operation_summary="Update a user's profile picture by user_id")
    def put(self, request, user_id):
        # ensure only a user can update his profile
        if request.user.user_id != user_id:
            return Response(
                data={
                    "message": "Only the user can update his/her profile picture"
                },
                status=status.HTTP_401_UNAUTHORIZED
            )
        return UpdateUserPicture().update(request, user_id)


class SendAnyEmailView(GenericAPIView, CreateModelMixin ):
    serializer_class = SendAnyEmailSerializer

    @swagger_auto_schema(operation_summary="Send any email to a user by user_id")
    def post(self, request):
        # ensure only a user can send email to himself
        return SendAnyEmailService().send(request)

class SendAnyEmailViewAsync(GenericAPIView, CreateModelMixin ):
    serializer_class = SendAnyEmailSerializer

    @swagger_auto_schema(operation_summary="Send any email to a user by user_id")
    def post(self, request):
        # ensure only a user can send email to himself
        return SendAnyEmailService2().send(request)