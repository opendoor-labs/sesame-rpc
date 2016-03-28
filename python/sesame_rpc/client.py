import requests
import sys
from sesame_rpc.lib import __version__ as sesame_version
from urllib.parse import urlparse

payload = None
r = requests.post('http://127.0.0.1:5000', payload)

class SesameClient:
    DEFAULT_ACCEPT_TYPE = ('application/octet-stream,application/x-google-protobuf,'
                           'application/vnd.google.protobuf,application/json')
    USER_AGENT = "sesame_rpc/{sesame_version} (python_version)".format(
        sesame_version=sesame_version,
        python_version=sys.version)

    def __init__(self, base_uri, routing_table, format='proto'):
        # urlparse(base_uri)
        self.base_uri = base_uri
        self.routing_table = routing_table
        self.format = format

    def request(self):
        pass
