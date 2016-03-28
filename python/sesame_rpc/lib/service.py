import abc
import inspect
from functools import wraps

from google.protobuf.reflection import GeneratedProtocolMessageType


class SesameService(abc.ABCMeta):
    """ SesameService is supplied as a metaclass for interfaces to ensure
        - concrete classes must implement abstract methods in interface
        - rpc methods are wrapped in typechecks (both on the way in and out)
    """
    def __new__(mcls, name, bases, namespace):
        cls = super().__new__(mcls, name, bases, namespace)

        if len(bases):
            assert len(bases) == 1, 'Concrete class of SesameService must be final.'
            rewrite_funcs(cls, bases[0])
        return cls


def rewrite_funcs(cls, iface):
    """Rewrite functions in cls so that they are each type checked (during run-time)
       according to function annotation in iface"""
    iface_funcs = inspect.getmembers(iface, predicate=inspect.isfunction)
    cls_funcs = dict(inspect.getmembers(cls, predicate=inspect.isfunction))

    for func_name, iface_func in iface_funcs:
        new_func = checked_func(iface_func, cls_funcs[func_name])
        setattr(cls, func_name, new_func)


def check_pb(func_name, arg_name, arg, annotation: GeneratedProtocolMessageType):
    if annotation is None:
        return

    if not isinstance(arg, annotation):
        msg = ('%s() %s has expected type %s but received type %s' %
               (func_name, arg_name, annotation.__name__, type(arg).__name__))
        raise TypeError(msg)


def checked_func(iface_func, func):
    spec = inspect.getfullargspec(iface_func)
    annotations = spec.annotations

    func_name = func.__name__
    func_spec = inspect.getfullargspec(func)
    if len(spec.args) != len(func_spec.args):
        raise TypeError('%s() and the interface have different args signatures')
    if len(spec.kwonlyargs) != len(func_spec.kwonlyargs):
        raise TypeError('%s() and the interface have different kwonlyargs signatures')
    if (spec.varargs is not None) != (func_spec.varargs is not None):
        raise TypeError('%s() and the interface have different *args signatures')
    if (spec.varkw is not None) != (func_spec.varkw is not None):
        raise TypeError('%s() and the interface have different **kwargs signatures')

    @wraps(func)
    def _checked_func(*args, **kwargs):
        for name, arg in [*zip(spec.args, args), *kwargs.items()]:
            check_pb(func_name, name, arg, annotations.get(name))

        result = func(*args, **kwargs)
        check_pb(func, 'return', result, annotations['return'])
        return result
    return _checked_func
