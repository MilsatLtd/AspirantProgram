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
    
class PasswordReset(serializers.Serializer):
    email = serializers.EmailField()
    profile_type = serializers.ChoiceField(choices=[('student', 'Student'), ('mentor', 'Mentor')])

class PasswordResetConfirm(serializers.Serializer):
    new_password = serializers.CharField(max_length=128)
    new_password2 = serializers.CharField(max_length=128)

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from django.contrib.auth.tokens import default_token_generator
from django.utils.http import urlsafe_base64_encode
from django.utils.encoding import force_bytes
from django.core.mail import send_mail
from django.conf import settings

class PasswordReset(APIView):
    def post(self, request, *args, **kwargs):
        serializer = PasswordReset(data=request.data)
        if serializer.is_valid():
            email = serializer.validated_data['email'] 
            profile_type = serializer.validated_data['profile_type']
            user = User.objects.filter(email=email).first()
            if user:
                token = default_token_generator.make_token(user)
                uid = urlsafe_base64_encode(force_bytes(user.pk))
                # Send email with reset link
                reset_link = f"{request.build_absolute_uri('/password_reset_confirm/')}{uid}/{token}/{profile_type}"
                send_mail(
                    'Password Reset for Your Account',
                    f'Please use the link below to reset your password: {reset_link}',
                    settings.EMAIL_HOST_USER,
                    [email],
                    fail_silently=False,
                )
                return Response({"message": "Password reset email sent."}, status=status.HTTP_200_OK)
            return Response({"message": "User not found."}, status=status.HTTP_404_NOT_FOUND)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)
    

from django.utils.http import urlsafe_base64_decode
from django.contrib.auth.tokens import default_token_generator

class PasswordResetConfirm(APIView):
    def post(self, request, uidb64, token, profile_type, *args, **kwargs):
        try:
            uid = urlsafe_base64_decode(uidb64).decode()
            user = User.objects.get(pk=uid)
        except (TypeError, ValueError, OverflowError, User.DoesNotExist):
            user = None

        if user is not None and default_token_generator.check_token(user, token):
            # Reset the appropriate profile's password
            new_password = request.data.get('password')
            if profile_type == 'student':
                user.set_password(new_password)
            elif profile_type == 'mentor':
                user.set_password2(new_password)
            user.save() 
            return Response({"message": "Password has been reset."}, status=status.HTTP_200_OK)

        return Response({"message": "Invalid token or user ID"}, status=status.HTTP_400_BAD_REQUEST)

