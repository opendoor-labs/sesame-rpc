require 'uri'

module SesameRpc
  module GenericService
    module Client
      attr_reader :base_uri, :routing_table, :format

      def initialize(base_uri, routing_table:, format: format = :proto)
        @base_uri = URI.parse(base_uri)
        @base_uri.scheme = 'https://' if @base_uri.scheme.nil?
        @routing_table = routing_table
        @format = format
      end

      private

      def request(input, context)
        uri = @base_uri.dup
        path = routing_table[@rpc_method_name]
        if path.nil?
          raise MissingRoutingInfo, "#{self.abstract_service.service_name}##{@rpc_method_name}"
        end

        http = Net::HTTP.new(uri.host, uri.port)
        request = Net::HTTP::Post.new(uri.request_uri)
        request['accept'] = 'application/octet-stream,application,application/x-google-protobuf,application/vnd.google.protobuf,application/json'

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
          case format(response.content_type)
          when :proto
            @output_type.decode(response.body)
          when :json
            @output_type.decode_json(response.body)
          end
        when Net::HTTPForbidden
        when Net::HTTPUnauthorized
        when Net::HTTPClientError
        when Net::HTTPServerError
        end
      end
    end
  end
end
