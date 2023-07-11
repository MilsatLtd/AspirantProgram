from rest_framework.renderers import JSONRenderer
from rest_framework.response import Response
from rest_framework.views import exception_handler
from rest_framework.exceptions import ValidationError, ParseError, PermissionDenied

class CustomJsonRenderer(JSONRenderer):
    def render(self, data, accepted_media_type=None, renderer_context=None):
        response = {
            'success': True,
            'message': ''
        }
        
        # Check if there are any errors in the response
        if renderer_context:
            response_status = renderer_context.get('response').status_code
            if response_status >= 400 and response_status < 600:
                response['success'] = False
                response['message'] = 'An error occurred while processing the request.'
        
        # Add the response data to the JSON object
        response.update({'data': data})
        
        return super().render(response, accepted_media_type, renderer_context)


def custom_exception_handler(exc, context):
    response = exception_handler(exc, context)
    print('catch error----')
    
    if isinstance(exc, ValidationError) or isinstance(exc, ParseError):
        response_data = {
            # 'success': False,
            'message': 'Validation error occurred while processing the request. \U0001F636',
            'errors': exc.detail
        }
        response_status = 400
        
        if response is not None:
                response.data = response_data
                response.status_code = response_status
        else:
            response = Response(response_data, status=response_status)

    if isinstance(exc, PermissionDenied) or isinstance(exc, PermissionError):
        response_data = {
            'message': str(exc),
        }
        return Response(response_data, status=exc.status_code)
        
    return response