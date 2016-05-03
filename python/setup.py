from setuptools import setup, find_packages

setup(
    name='sesame-rpc',
    version='0.1.0',
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
    dependency_links=['https://github.com/opendoor-labs/protobuf-py3.git@2.6.1#egg=protobuf-py3-2.6.1'],
    zip_safe=False
)
