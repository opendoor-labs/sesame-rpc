require 'protobuf'
require 'sesame_rpc'
# This is the dirtiest thing I've ever done, but I don't have much option
# because of the generated nature of the code.
[
  Protobuf::Rpc::Service,
  Protobuf::Rpc::ServiceFilters::InstanceMethods,
  Protobuf::Rpc::ServiceFilters,
].each do |klass|
  (klass.instance_methods - Object.instance_methods).each do |meth|
    begin
      klass.send(:remove_method, meth)
    rescue NameError
      :nothing
    end
  end

  (klass.methods - Object.methods).each do |meth|
    begin
      klass.singleton_class.send(:remove_method, meth)
    rescue NameError
      :nothing
    end
  end

  begin
    klass.send(:remove_method, :initialize)
  rescue NameError
    :nothing
  end

  begin
    klass.singleton_class.send(:remove_method, :inherited)
    klass.singleton_class.send(:remove_method, :included)
  rescue NameError
    :nothing
  end
end

class Protobuf::Rpc::Service
  include SesameRpc::GenericService
end
