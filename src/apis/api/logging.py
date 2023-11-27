from logging import Handler
import requests, json, traceback

class SlackLogHandler(Handler):
   def __init__(self, logging_url="", stack_trace=False):
      Handler.__init__(self)
      self.logging_url = logging_url
      self.stack_trace = stack_trace
      
   def emit(self, record):
      message = '%s' % (record.getMessage())
      if self.stack_trace:
         if record.exc_info:
            message += '\n'.join(traceback.format_exception(*record.exc_info))
            requests.post(self.logging_url, data=json.dumps({"text":message} ))
