import inspect
from functools import wraps

from flask import Flask, request, make_response
from google.protobuf.json_format import Parse, MessageToJson
from werkzeug.wrappers import Request

from humans_pb2 import GetHumanRequest
from humans_service import IHumanService
from sesame_rpc.play import HumanService

app = Flask('sesame-demo-app')

def sesame_api(iface_func):
    spec = inspect.getfullargspec(iface_func)
    arg = [a for a in spec.args if a != 'self'][0]
    input_type = spec.annotations[arg]

    def decorator(f):
        @wraps(f)
        def wrapper(*args, **kwargs):
            req = input_type()
            if content_mimetype(request) == 'proto':
                req.ParseFromString(request.get_data())
            else:
                Parse(request.data, req)

            res = f(req)

            if accept_mimetype(request) == 'proto':
                response = make_response(res.SerializeToString())
                response.content_type = 'application/octet-stream'
            else:
                response = make_response(MessageToJson(res))
                response.content_type = 'application/json'
            return response
        return wrapper

    return decorator


@app.route('/human_info', methods=['POST'])
@sesame_api(IHumanService.get_human)
def get_human(get_human_request):
    return HumanService().get_human(get_human_request)


@app.route('/ping')
def ping():
    print(request)
    request.get_data()
    return 'pong'


proto_mimetypes = ['application/octet-stream',
                   'application/x-google-protobuf',
                   'application/vnd.google.protobuf']
def accept_mimetype(r: Request):
    if any(m in r.accept_mimetypes for m in proto_mimetypes):
        return 'proto'
    else:
        return 'json'


def content_mimetype(r: Request):
    if any(m in r.content_type for m in proto_mimetypes):
        return 'proto'
    else:
        return 'json'


@app.route('/human_info_2', methods=['POST'])
def human_info():
    req = GetHumanRequest()
    if content_mimetype(request) == 'proto':
        req.ParseFromString(request.get_data())
    else:
        Parse(request.data, req)

    service = HumanService()
    human = service.get_human(req)

    if accept_mimetype(request) == 'proto':
        response = make_response(human.SerializeToString())
        response.content_type = 'application/octet-stream'
    else:
        response = make_response(MessageToJson(human))
        response.content_type = 'application/json'

    return response


if __name__ == '__main__':
    app.run(debug=True)
