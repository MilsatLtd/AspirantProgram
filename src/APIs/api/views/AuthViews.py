from rest_framework_simplejwt.serializers import TokenObtainPairSerializer
from rest_framework_simplejwt.tokens import RefreshToken
from rest_framework.permissions import IsAuthenticated
from drf_yasg.utils import swagger_auto_schema
from ..serializers import *
from ..services.UserService import *
from rest_framework import mixins
from rest_framework.generics import GenericAPIView


class MyTokenObtainPairSerializer(TokenObtainPairSerializer):
    token_class = RefreshToken

    @classmethod
    def get_token(cls, user):
        token = super().get_token(user)
        token['full_name'] = user.first_name + ' ' + user.last_name
        token['email'] = user.email
        token['role'] = user.recent_role
        return token



class ChangePasswordView(mixins.UpdateModelMixin, GenericAPIView):
    serializer_class = ChangePasswordSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema(operation_summary="Change password")
    def put(self, request):
        return ChangePassword().update(request)

