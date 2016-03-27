require "sesame_rpc/version"
require 'google/protobuf'

require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/inflections'
require 'sesame_rpc/client'

# hopefully we don't have to do this for long
# We have to do it for now because google doesn't
root_dir = File.expand_path('./pb', File.dirname(__FILE__))
$:.unshift(root_dir)
Dir[File.join(root_dir, '**/*.rb')].each { |f| require f.sub(root_dir, '').sub(/^\//, '') }

module SesameRpc
  module Errors
    class InvalidInput < ArgumentError; end
    class InvalidOutput < RuntimeError; end
  end

  module GenericService
    extend ActiveSupport::Concern

    included do
      cattr_accessor :service_name, :rpcs
      self.rpcs = {}.with_indifferent_access

      attr_reader :input_type, :output_type
    end

    module ClassMethods
      def rpc(name, input_type, output_type)
        meth_name = name.to_s.underscore.to_sym
        value = {
          service: self,
          name: meth_name,
          input_type: input_type,
          output_type: output_type
        }.with_indifferent_access

        rpcs[meth_name] = value
      end

      def inherited(klass)
        impl_wrapper_module = SesameRpc::GenericService.impl_wrapper_module(klass)
        klass.prepend(impl_wrapper_module)

        client_class = SesameRpc::GenericService.generate_client(klass)
        const_set(:Client, client_class)
      end
    end

    def self.impl_wrapper_module(service)
      Module.new do
        service.rpcs.each do |name, defn|

          define_method name do |input, context|
            @input_type = defn[:input_type]
            @output_type = defn[:output_type]

            unless input.kind_of?(defn[:input_type])
              raise SesameRpc::Errors::InvalidInput, "#{service.service_name}##{name} expects #{defn[:input_type].name}, got #{input.class.name}"
            end

            output = super(input, context)

            unless output.kind_of?(defn[:output_type])
              raise SesameRpc::Errors::InvalidOutput, "#{service.service_name}##{name} expects #{defn[:output_type].name}, got #{output.class.name}"
            end

            output
          end
        end
      end
    end

    def self.generate_client(service)
      Class.new do
        include SesameRpc::GenericService::Client

        define_method(:abstract_service) { service }

        define_method(:input_for) { |name| service.rpcs[name] }

        service.rpcs.each do |name, defn|
          define_method name do |input, context|
            @input_type = defn[:input_type]
            @output_type = defn[:output_type]
            @rpc_method_name = defn[:name]

            unless input.kind_of?(defn[:input_type])
              raise SesameRpc::Errors::InvalidInput, "#{service.service_name}##{name} expects #{defn[:input_type].name}, got #{input.class.name}"
            end

            output = request(input, context)

            unless output.kind_of?(defn[:output_type])
              raise SesameRpc::Errors::InvalidOutput, "#{service.service_name}##{name} expects #{defn[:output_type].name}, got #{output.class.name}"
            end

            output
          end
        end
      end
    end
  end
end
