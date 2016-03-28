import inspect
from functools import wraps

from flask import Request, request, make_response
from google.protobuf.json_format import Parse, MessageToJson


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


proto_mimetypes = ['application/octet-stream',
                   'application/x-google-protobuf',
                   'application/vnd.google.protobuf']
def accept_mimetype(r: Request):
    return 'proto' if any(m in r.accept_mimetypes for m in proto_mimetypes) else 'json'


def content_mimetype(r: Request):
    return 'proto' if any(m in r.content_type for m in proto_mimetypes) else 'json'
