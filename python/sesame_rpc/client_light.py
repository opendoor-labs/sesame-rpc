import requests

from humans_pb2 import GetHumanRequest, Human
from google.protobuf.json_format import MessageToJson

uri = "http://localhost:5000/human_info_2"

req = GetHumanRequest()
req.email = 'foo'

proto_mimetype = 'application/octet-stream,application/x-google-protobuf'
json_mimetype = 'application/json'

pb_pb = {'Accept': proto_mimetype, 'Content-Type': proto_mimetype}
pb_json = {'Accept': proto_mimetype, 'Content-Type': json_mimetype}
json_pb = {'Accept': json_mimetype, 'Content-Type': proto_mimetype}
json_json = {'Accept': json_mimetype, 'Content-Type': json_mimetype}


resp = requests.post(uri, data=req.SerializeToString(), headers=pb_pb)


resp2 = requests.post(uri, data=MessageToJson(req), headers=json_json)



print(resp)

h = Human()
h.ParseFromString(resp.content)
