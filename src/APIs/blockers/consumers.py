import json
from channels.generic.websocket import AsyncWebsocketConsumer
from .models import Blocker, Comment
from .serializers import BlockerSerializer, CommentSerializer


class BlockerConsumer(AsyncWebsocketConsumer):
    async def connect(self):
        await self.accept()

        await self.channel_layer.group_add(
            'blockers',
            self.channel_name
        )

    async def receive(self, text_data=None):
        # brouadcast  message to group
        await self.channel_layer.group_send(
            'blockers',
            {
                'type': 'blocker_update',
                'message': text_data
            }
        )

    async def blocker_update(self, event):
        message = event['message']
        await self.send(text_data=json.dumps({
            'type': 'blocker_update',
            'message': message
        }))

    async def disconnect(self, close_code):
        await self.channel_layer.group_discard(
            'blockers',
            self.channel_name
        )

    # async def receive(self, text_data):
    #     data = json.loads(text_data)
    #     print(data)
    #     message = data['message']

    #     blocker_id = message.get('blocker_id')
    #     comment = message.get('comment')

    #     if blocker_id and comment:
    #         blocker = await self.create_comment(blocker_id, comment)
    #         await self.channel_layer.group_send(
    #             'blockers',
    #             {
    #                 'type': 'blocker_update',
    #                 'message': BlockerSerializer(blocker).data
    #             }
    #         )

    # async def blocker_update(self, event):
    #     message = event['message']
    #     await self.send(text_data=json.dumps({
    #         'type': 'blocker_update',
    #         'message': message
    #     }))

    # async def create_comment(self, blocker_id, comment):
    #     blocker = await self.get_blocker(blocker_id)
    #     return Comment.objects.create(blocker=blocker, message=comment)

    # async def get_blocker(self, blocker_id):
        return await self.scope['session'].async_get('blocker', lambda: Blocker.objects.get(pk=blocker_id))
