import os
import sys

root_dir = os.path.join(os.path.dirname(__file__), '..')
pb_dir = os.path.join(os.path.dirname(__file__), 'lib/pb')
sys.path.append(root_dir)
sys.path.append(pb_dir)

from google.protobuf.empty_pb2 import Empty
from humans_pb2 import GetHumanRequest, Human
from sesame_rpc.lib.pb.humans_service import IHumanService


class HumanService(IHumanService):
    def get_human(self, get_human_request: GetHumanRequest) -> Human:
        human = Human()
        human.email = get_human_request.email
        return human

    def info(self, empty: Empty) -> Human:
        human = Human()
        human.email = 'info'
        return human


# service = HumanService()
# request = GetHumanRequest()
# request.email = 'foo'
