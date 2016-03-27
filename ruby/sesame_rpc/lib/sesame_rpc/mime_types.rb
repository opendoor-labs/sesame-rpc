require 'mime/types'

module SesameRpc
  module Mime
    def self.add_old_proto_mime_types(types)
      stream = MIME::Types['application/octet-stream'].first

      types.each do |type|
        existing_mime = MIME::Types[type].first
        next if existing_mime.nil?
        proto = MIME::Type.new(type)
        proto.obsolete = true
        proto.use_instead = stream
        MIME::Types.add(proto)
      end
    end

    add_old_proto_mime_types(%w(application/protobuf application/x-google-protobuf application/vnd.google.protobuf))

    def self.format_from_type(type_string)
      mime = MIME::Types[type_string].detect { |t| resolve_type(t) }
      mime.to_s == 'application/octet-stream' ? :proto : :json
    end

    def self.resolve_type(type)
      return nil if type.nil?
      if type.use_instead
        resolve_type(type.use_instead)
      else
        type
      end
    end
  end
end
