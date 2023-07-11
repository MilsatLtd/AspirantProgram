from django.urls import re_path
from .consumers import BlockerConsumer

websocket_urlpatterns = [
    re_path(r'ws/blockers/$', BlockerConsumer.as_asgi()),
]
