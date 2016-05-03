## Dependencies

Python dependencies include protobuf-2.6.1 and protobuf3-to-dict.

Make sure to install protobuf3-to-dict and not protobuf-to-dict, as the former
is compatible with Python 3 while the latter is not.

protobuf-2.6.1 is not compatible with Python 3 out of the box, but it can be
made to be compatible using the `2to3` tool. To install the dependency, run the
source code files listed below through 2to3 and then execute
`python setup.py install`.

TODO: figure out how to package the protobuf-2.6.1 dependency. One solution is
to fork protobuf-2.6.1 with the relevant source files passed through 2to3.

The files to convert for protobuf-2.6.1 are:

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
