from rest_framework import permissions
from django.conf import settings
import jwt
from ..common.enums import ROLE


class IsMentee(permissions.BasePermission):
    def __init__(self, allowed_roles=[ROLE.STUDENT.value]):
        self.allowed_roles = allowed_roles

    def has_permission(self, request, view):
        token = request.headers['Authorization'].split(' ')[1]
        if token:
            try:
                payload = jwt.decode(
                    token, settings.SECRET_KEY, algorithms=['HS256'])
                role = payload['role']
                return bool(request.user and role in self.allowed_roles)
            except jwt.ExpiredSignatureError:
                return False
            except jwt.exceptions.DecodeError:
                return False
        else:
            return False


class IsMentor(permissions.BasePermission):
    def __init__(self, allowed_roles=[ROLE.MENTOR.value]):
        self.allowed_roles = allowed_roles

    def has_permission(self, request, view):
        token = request.headers['Authorization'].split(' ')[1]
        if token:
            try:
                payload = jwt.decode(
                    token, settings.SECRET_KEY, algorithms=['HS256'])
                role = payload['role']
                return bool(request.user and role in self.allowed_roles)
            except jwt.ExpiredSignatureError:
                return False
            except jwt.exceptions.DecodeError:
                return False
        else:
            return False


class IsAdmin(permissions.BasePermission):
    def __init__(self, allowed_roles=[ROLE.ADMIN.value]):
        self.allowed_roles = allowed_roles

    def has_permission(self, request, view):
        token = request.headers['Authorization'].split(' ')[1]
        if token:
            try:
                payload = jwt.decode(
                    token, settings.SECRET_KEY, algorithms=['HS256'])
                role = payload['role']
                return bool(request.user and role in self.allowed_roles)
            except jwt.ExpiredSignatureError:
                return False
            except jwt.exceptions.DecodeError:
                return False
        else:
            return False


def get_claim(request):
    token = request.headers['Authorization'].split(' ')[1]
    if token:
        try:
            payload = jwt.decode(
                token, settings.SECRET_KEY, algorithms=['HS256'])
            return payload
        except jwt.ExpiredSignatureError:
            return False
        except jwt.exceptions.DecodeError:
            return False
        except Exception as e:
            return False
    else:
        return False
