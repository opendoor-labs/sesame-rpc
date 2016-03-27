require 'uri'
require 'sesame_rpc/version'
require 'sesame_rpc/mime_types'
require 'sesame_rpc/errors'

module SesameRpc
  module GenericService
    module Client
      DEFAULT_ACCEPT_TYPE = 'application/octet-stream,application/x-google-protobuf,application/vnd.google.protobuf,application/json'
      USER_AGENT = "sesame_rpc/#{SesameRpc::VERSION} (#{RUBY_DESCRIPTION})"

      attr_reader :base_uri, :routing_table, :format

      def initialize(base_uri, routing_table:, format: format = :proto)
        @base_uri = URI.parse(base_uri)
        @base_uri.scheme = 'https://' if @base_uri.scheme.nil?
        @routing_table = routing_table.with_indifferent_access
        @format = format
      end

      private

      def request(input, context)
        uri = @base_uri.dup
        path = routing_table[@rpc_method_name]
        if path.nil?
          raise MissingRoutingInfo, "#{self.abstract_service.service_name}##{@rpc_method_name}"
        end
        uri.path = path

        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.request_uri)
        request['accept'] = DEFAULT_ACCEPT_TYPE
        request['User-Agent'] = USER_AGENT

        case format
        when :proto
          request.content_type = 'application/octet-stream'
          request.body = input.to_proto
        when :json
          request.content_type = 'application/json'
          request.body = input.to_json
        end

        response = http.request(request)

        case response
        when Net::HTTPSuccess
          if SesameRpc::Mime.format_from_type(response.content_type) == :proto
            @output_type.decode(response.body)
          else
            @output_type.decode_json(response.body)
          end
        else
          error_klass = SesameRpc.http_error_by_status(response.code)
          raise error_klass, response.body
        end
      end
    end
  end
end
