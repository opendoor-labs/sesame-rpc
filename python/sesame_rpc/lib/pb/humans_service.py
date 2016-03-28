# Generated file from od.api.v1.humans

import abc
from sesame_rpc.lib.service import SesameService
from humans_pb2 import GetHumanRequest, Human
from google.protobuf.empty_pb2 import Empty

class IHumanService(metaclass=SesameService):
    __service_name__ = 'od.api.v1.humans.HumanService'

    @abc.abstractmethod
    def info(self, empty: Empty) -> Human:
        raise NotImplementedError

    @abc.abstractmethod
    def get_human(self, get_human_request: GetHumanRequest) -> Human:
        raise NotImplementedError
