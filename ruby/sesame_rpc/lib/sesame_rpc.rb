require "sesame_rpc/version"
require 'google/protobuf'

require 'active_support'
require 'active_support/core_ext/hash/indifferent_access'
require 'active_support/core_ext/string/inflections'

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
    end

    module ClassMethods
      def rpc(name, input_type, output_type)
        value = { service: self, name: name, input_type: input_type, output_type: output_type }
        rpcs[name] = value
        rpcs[name.to_s.underscore] = value
      end

      def inherited(klass)
        wrapper_module =  SesameRpc::GenericService.wrapper_module(klass)
        klass.prepend(wrapper_module)
      end
    end

    def self.wrapper_module(service)
      Module.new do
        service.rpcs.each do |name, defn|

          define_method name do |input, context|
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
  end
end
