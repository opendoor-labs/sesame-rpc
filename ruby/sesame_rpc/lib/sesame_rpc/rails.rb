require 'sesame_rpc'
require 'sesame_rpc/rails/controller_helper'

module SesameRpc
  module Rails
    class Railtie < ::Rails::Railtie
      gem_lib_path = File.dirname(__FILE__)
      gem_rails_path = File.expand_path('./rails', gem_lib_path)

      railtie_name 'sesame_rpc_railtie'

      initializer 'sesame_rpc.register_mime' do
        ::Mime::Type.register 'application/octet-stream', :proto, %w(application/x-google-protobuf application/vnd.google.protobuf)
      end

      rake_tasks do
        load File.join(gem_rails_path, 'tasks.tasks')
      end
    end
  end
end
