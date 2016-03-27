require 'sesame_rpc/errors'
module SesameRpc
  module Rails
    # Provides helpers for your controller to automatically map to a proto service implementation
    #
    # @example
    #
    # class MyController < ApplicationController
    #   include SesameRpc::Rails::ControllerHelpers
    #
    #   before_action :authenticate_yo!
    #
    #   implement_rpc MyServiceImplementation
    #
    #   private
    #   def sesame_context
    #     context = super
    #     context[:user] = current_user,
    #     context[:jwt] = current_jwt
    #     context
    #   end
    #
    # end
    module ControllerHelper
      extend ActiveSupport::Concern

      def sesame_content_type
        @sesame_content_type ||= ::Mime::Type.parse(request.content_type).first.try(:symbol)
      end

      def sesame_accept_type
        @sesame_accept_type ||= ::Mime::Type.parse(request.headers['HTTP_ACCEPT'])
      end

      def parse_sesame_in
        if sesame_content_type == :proto
          @sesame_rpc_input = @sesame_rpc_input_type.decode(request.raw_post)
        else
          @sesame_rpc_input = @sesame_rpc_input_type.decode_json(request.raw_post)
        end
      rescue Google::Protobuf::ParseError => e
        render json: { error: "Bad Request #{e.message}" }, status: :bad_request
      end

      def render_sesame_out
        if sesame_accept_type
          send_data @sesame_rpc_output.to_proto, type: 'application/octet-stream', disposition: 'inline'
        else
          render json: @sesame_rpc_output.to_json
        end
      end

      def rescue_from_sesame_http_error(ex)
        render json: { errors: ex.message }, status: ex.status
      end

      def sesame_context
        {}
      end

      module ClassMethods

        def implement_rpc(service_impl)
          rescue_from SesameRpc::HTTPError, with: :rescue_from_sesame_http_error

          service_impl.rpcs.each do |name, rpc|
            prepend_before_action "prepare_sesame_rpc_#{name}", only: [name]

            define_method "prepare_sesame_rpc_#{name}" do
              @sesame_rpc_input_type = rpc[:input_type]
              @sesame_rpc_output_type = rpc[:output_type]
              @sesame_rpc_method_name = rpc[:name]

              @sesame_rpc_input = parse_sesame_in
              @sesame_rpc_context = sesame_context
            end

            define_method name do
              @sesame_rpc_output = service_impl.new.send(
                @sesame_rpc_method_name,
                @sesame_rpc_input,
                @sesame_rpc_context
              )
              render_sesame_out
            end
          end
        end
      end
    end
  end
end

