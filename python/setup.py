from setuptools import setup, find_packages

# sesame-rpc has a Python 3 port of protobuf-2.6.1 as a requirement. Such a port
# can be installed from the link:
# https://github.com/opendoor-labs/protobuf-py3.git@2.6.1#egg=protobuf-py3-2.6.1
# If you want to install sesame-rpc as a dependency to your project you must add
# the above as a dependency to your project as well. This dependency could be
# added here to the dependency_links kwarg of setup but we did not becasue
# depedency links are deprecated and slated for removal.
setup(
    name='sesame-rpc',
    version='0.1.1',
    description='Protobuf service definition',
    author='Opendoor Labs Inc.',
    email='developers@opendoor.com',
    keywords=['protobuf'],
    url='https://github.com/opendoor-labs/sesame-rpc',
    packages=find_packages(exclude=['contrib', 'docs', 'tests']),
    install_requires=[
        'Flask==0.10.1',
        'itsdangerous==0.24',
        'Jinja2==2.8',
        'MarkupSafe==0.23',
        'protobuf3-to-dict==0.1.2',
        'six==1.10.0',
        'Werkzeug==0.11.9',
    ],
    zip_safe=False
)
