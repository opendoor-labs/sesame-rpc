import inspect
import json
from functools import wraps

from flask import Request, request, make_response

# The protobuf_to_dict module here was copied from the protobuf3_to_dict PyPi
# package into the Opendoor fork of protobuf-2.6.1.
# Compare https://github.com/kaporzhu/protobuf-to-dict/blob/master/src/protobuf_to_dict.py
# and https://github.com/opendoor-labs/protobuf-py3/blob/master/google/protobuf/protobuf_to_dict.py
from google.protobuf.protobuf_to_dict import dict_to_protobuf, protobuf_to_dict


def sesame_api(iface_func):
    """Decorator that converts requests and response depending on the accept and
       content-type of an incoming request.

       Usage:

       message Employee {
         uint64 id = 1;
         string email = 2;
       }

       message GetEmployeeRequest {
         uint64 id = 1;
       }

       service EmployeeService {
         rpc get_employee(GetEmployeeRequest) returns (Employee) {}
       }

       @app.route('/employee', methods=['POST'])
       @sesame_api(IEmployeeService.get_employee)
       def get_employee(get_employee_request: GetEmployeeRequest):
           return EmployeeService().get_employee(get_employee_request)
    """
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
                request_dict = json.loads(request.data.decode())
                req = dict_to_protobuf(input_type, request_dict)

            res = f(req)

            if accept_mimetype(request) == 'proto':
                response = make_response(res.SerializeToString())
                response.content_type = 'application/octet-stream'
            else:
                response = make_response(json.dumps(protobuf_to_dict(res)))
                response.content_type = 'application/json'
            return response
        return wrapper

    return decorator


proto_mimetypes = ['application/octet-stream',
                   'application/x-google-protobuf',
                   'application/vnd.google.protobuf']
def accept_mimetype(r: Request):
    return 'proto' if any(m in r.accept_mimetypes for m in proto_mimetypes) else 'json'


def content_mimetype(r: Request):
    return 'proto' if any(m in r.content_type for m in proto_mimetypes) else 'json'
