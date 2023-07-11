from rest_framework import generics
from rest_framework.generics import RetrieveAPIView
from ..serializers import Blocker, Comment
from ..serializers import BlockerSerializer, CommentSerializer
from drf_yasg.utils import swagger_auto_schema
from ..services.BlockerService import GetBlockerByTrack
from rest_framework.permissions import IsAuthenticated
from ..backends.map_permissions import IsMentor, IsMentee, IsAdmin
from rest_framework.exceptions import PermissionDenied

class BlockerListCreateView(generics.ListCreateAPIView):
    queryset = Blocker.objects.all()
    serializer_class = BlockerSerializer
    permission_classes = (IsAuthenticated,)


class BlockerTrack(RetrieveAPIView):
    serializer_class = BlockerSerializer
    permission_classes = (IsAuthenticated,)

    @swagger_auto_schema(operation_summary="Get all blockers for a track")
    def get(self, request, track_id):
        return GetBlockerByTrack().get(request, track_id)
    
        
class BlockerRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Blocker.objects.all()
    serializer_class = BlockerSerializer
    http_method_names = ['get', 'put', 'delete']
    lookup_field = 'blocker_id'

    # ensure that only the student that created the blocker can update or delete it
    def get_permissions(self):
        if self.request.method in ['PUT', 'DELETE']:
            self.permission_classes = (IsAuthenticated,)
        else:
            self.permission_classes = (IsAuthenticated,)
        return super().get_permissions()
    
    # ensure that only the student that created the blocker can update or delete it
    def perform_update(self, serializer):
        if self.request.user != serializer.instance.user:
            raise PermissionDenied( detail="You are not authorized to update this blocker. Only the student that created it can update it.")
        serializer.save()

    # ensure that only the student that created the blocker can update or delete it
    def perform_destroy(self, instance):
        if self.request.user != instance.user:
            raise PermissionDenied( detail="You are not authorized to delete this blocker. Only the student that created it can delete it.")
        instance.delete()

class CommentListCreateView(generics.ListCreateAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    permission_classes = (IsAuthenticated,)
    # list all comments in a blocker
    def get_queryset(self):
        blocker_id = self.kwargs['blocker_id']
        return Comment.objects.filter(blocker_id=blocker_id)
    
    # create a comment in a blocker
    def perform_create(self, serializer):
        blocker_id = self.kwargs['blocker_id']
        serializer.save(blocker_id=blocker_id)



class CommentRetrieveUpdateDestroyView(generics.RetrieveUpdateDestroyAPIView):
    queryset = Comment.objects.all()
    serializer_class = CommentSerializer
    permission_classes = (IsAuthenticated,)

    http_method_names = ['get', 'put', 'delete']
    
    # ensure that only the student that created the comment can update or delete it
    def perform_update(self, serializer):
        if self.request.user != serializer.instance.user:
            raise PermissionDenied( detail="You are not authorized to update this comment. Only the student that created it can update it.")
        serializer.save()

    # ensure that only the student that created the comment can update or delete it
    def perform_destroy(self, instance):
        if self.request.user != instance.user:
            raise PermissionDenied( detail="You are not authorized to delete this comment. Only the student that created it can delete it.")
        instance.delete()
