# Generated by the protocol buffer compiler.  DO NOT EDIT!
# source: fruits.proto

import sys
_b=sys.version_info[0]<3 and (lambda x:x) or (lambda x:x.encode('latin1'))
from google.protobuf import descriptor as _descriptor
from google.protobuf import message as _message
from google.protobuf import reflection as _reflection
from google.protobuf import symbol_database as _symbol_database
from google.protobuf import descriptor_pb2
# @@protoc_insertion_point(imports)

_sym_db = _symbol_database.Default()




DESCRIPTOR = _descriptor.FileDescriptor(
  name='fruits.proto',
  package='od.api.v1.fruits',
  syntax='proto3',
  serialized_pb=_b('\n\x0c\x66ruits.proto\x12\x10od.api.v1.fruits\"\x16\n\x05\x41pple\x12\r\n\x05\x63olor\x18\x01 \x01(\tb\x06proto3')
)
_sym_db.RegisterFileDescriptor(DESCRIPTOR)




_APPLE = _descriptor.Descriptor(
  name='Apple',
  full_name='od.api.v1.fruits.Apple',
  filename=None,
  file=DESCRIPTOR,
  containing_type=None,
  fields=[
    _descriptor.FieldDescriptor(
      name='color', full_name='od.api.v1.fruits.Apple.color', index=0,
      number=1, type=9, cpp_type=9, label=1,
      has_default_value=False, default_value=_b("").decode('utf-8'),
      message_type=None, enum_type=None, containing_type=None,
      is_extension=False, extension_scope=None,
      options=None),
  ],
  extensions=[
  ],
  nested_types=[],
  enum_types=[
  ],
  options=None,
  is_extendable=False,
  syntax='proto3',
  extension_ranges=[],
  oneofs=[
  ],
  serialized_start=34,
  serialized_end=56,
)

DESCRIPTOR.message_types_by_name['Apple'] = _APPLE

Apple = _reflection.GeneratedProtocolMessageType('Apple', (_message.Message,), dict(
  DESCRIPTOR = _APPLE,
  __module__ = 'fruits_pb2'
  # @@protoc_insertion_point(class_scope:od.api.v1.fruits.Apple)
  ))
_sym_db.RegisterMessage(Apple)


# @@protoc_insertion_point(module_scope)
