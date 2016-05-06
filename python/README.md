## Dependencies

sesame-rpc depends on a Python 3 port of protobuf-2.6.1 which includes support for
converting protobuf messages to and from JSON, which can be installed from the link:

https://github.com/opendoor-labs/protobuf-py3.git@2.6.1#egg=protobuf-py3-2.6.1

If you want to install sesame-rpc as a dependency to your project you must add
the above as a dependency to your project as well. This dependency could be
added to the sesame-rpc setup.py using the `dependency_links` kwarg of `setup` but
we decided not to because dependency links are deprecated and slated for
removal.