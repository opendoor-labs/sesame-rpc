# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sesame_rpc/version'

Gem::Specification.new do |spec|
  spec.name          = "sesame_rpc"
  spec.version       = SesameRpc::VERSION
  spec.authors       = ["Daniel Neighman"]
  spec.email         = ["has.sox@gmail.com"]

  spec.summary       = %q{Unopinionated protobuf RPC for Ruby}
  spec.description   = %q{Unopinionated protobuf RPC for Ruby}
  spec.homepage      = "https://github.com/opendoor-labs/sesame-rpc"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = 'http://localhost' # "TODO: Set to 'http://mygemserver.com'"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'protobuf', '~>3.6.7'
  spec.add_dependency 'activesupport', '>= 3.0'

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
end
