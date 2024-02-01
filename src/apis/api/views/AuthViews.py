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
    
class PasswordResetSerializer(serializers.Serializer):
    email = serializers.EmailField()
    profile_type = serializers.ChoiceField(choices=[('student', 'Student'), ('mentor', 'Mentor')])

class PasswordResetConfirmSerializer(serializers.Serializer):
    token = serializers.IntegerField()
    password = serializers.CharField(max_length=128)
    confirm_password = serializers.CharField(max_length=128)

    def validate(self, data):
        if data['password'] != data['confirm_password']:
            raise serializers.ValidationError("Passwords do not match")
        return data

from rest_framework.generics import GenericAPIView
from rest_framework.mixins import CreateModelMixin
from rest_framework.response import Response
from rest_framework import status
from django.core.mail import send_mail
from django.conf import settings
import random, string
from datetime import datetime, timedelta
import html2text

def generate_token():
    # Generate a random 6-digit token
    return int(''.join(random.choices(string.digits[1:], k=6)))

class PasswordReset(GenericAPIView, CreateModelMixin ):
    serializer_class = PasswordResetSerializer

    @swagger_auto_schema(operation_summary="Send password reset email")
    def post(self, request, *args, **kwargs):
        serializer = PasswordResetSerializer(data=request.data)
        if serializer.is_valid():
            email = serializer.validated_data['email'] 
            profile_type = serializer.validated_data['profile_type']
            user = User.objects.filter(email=email).first()
            if not user:
                return Response({"message": "No user found with this email address."}, status=status.HTTP_404_NOT_FOUND)
            if user:
                token = generate_token()

                while User.objects.filter(password_reset_token=token, password_reset_token_used=False, password_reset_token_expiry__gte=datetime.now()).exists():
                    token = generate_token()
                user.password_reset_token = token
                user.password_reset_token_used = False
                user.password_reset_token_expiry = datetime.now() + timedelta(minutes=30)
                user.password_reset_token_profile = profile_type
                user.save()
                
                send_mail(
                    'Password Reset for Your Account',
                     html2text.HTML2Text().handle(f'Please use this 6 digit token to reset your password: {token}'),
                    settings.EMAIL_HOST_USER,
                    [email],
                    fail_silently=False,
                )
                return Response({"message": "Password reset email sent."}, status=status.HTTP_200_OK)
            return Response({"message": "Something went wrong"}, status=status.HTTP_500_INTERNAL_SERVER_ERROR)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class PasswordResetConfirm(GenericAPIView, CreateModelMixin ):
    serializer_class = PasswordResetConfirmSerializer

    @swagger_auto_schema(operation_summary="Confirm password reset")
    def post(self, request, *args, **kwargs):
        serializer = PasswordResetConfirmSerializer(data=request.data)
        if serializer.is_valid():
            token = serializer.validated_data['token']
            user = User.objects.filter(password_reset_token=token, password_reset_token_used=False, password_reset_token_expiry__gte=datetime.now()).first()
            if not user:
                return Response({"message": "Invalid token"}, status=status.HTTP_400_BAD_REQUEST)
            
            new_password = request.data.get('password')
            if user.password_reset_token_profile == 'student':
                if user.check_password2(new_password)[0]:
                    return Response({"message": "You can't use the same password for your intern and mentor profile"}, status=status.HTTP_400_BAD_REQUEST)
                user.set_password(new_password)
            elif user.password_reset_token_profile == 'mentor':
                if user.check_password(new_password)[0]:
                    return Response({"message": "You can't use the same password for your intern and mentor profile"}, status=status.HTTP_400_BAD_REQUEST)
                user.set_password2(new_password)
            
            user.password_reset_token_used = True
            user.password_reset_token = None
            user.save() 
            return Response({"message": "Password has been reset."}, status=status.HTTP_200_OK)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

