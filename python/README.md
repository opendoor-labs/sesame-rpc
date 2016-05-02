## Dependencies

Python dependencies include protobuf-2.6.1 and protobuf_to_dict.

These dependencies are not compatible with Python 3, but they can be made to
be compatible using the `2to3` tool. To install them run the source code files
through 2to3 and then execute `python setup.py install`.

The files to convert are:

```
protobuf_to_dict:

  - src/protobuf_to_dict.py

protobuf-2.6.1:

  - protobuf/descriptor.py
  - protobuf/internal/cpp_message.py
  - protobuf/internal/decoder.py
  - protobuf/internal/python_message.py
  - protobuf/internal/type_checkers.py
  - protobuf/internal/message_factory_test.py
  - protobuf/internal/message_factory_python_test.py
  - protobuf/internal/message_python_test.py
  - protobuf/internal/message_test.py
  - protobuf/internal/reflection_test.py
  - protobuf/internal/test_util.py
  - protobuf/internal/text_format_test.py
  - protobuf/message_factory.py
  - protobuf/text_encoding.py
  - protobuf/text_format.py
```
