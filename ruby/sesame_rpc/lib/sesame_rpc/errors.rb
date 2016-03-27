module SesameRpc
  class HTTPError < StandardError; end
  @@http_errors_by_status = {}

  def self.http_error_by_status(status)
    @@http_errors_by_status[status]
  end

  make_http_error = ->(name, status, inherit_from=SesameRpc::HTTPError) do
    klass = Class.new(inherit_from) do
      define_method(:status) { status }
    end

    const_set(name, klass)
    @@http_errors_by_status[status] = klass
    @@http_errors_by_status[status.to_s] = klass
  end

  make_http_error[:JSONParseError, 400]
  make_http_error[:ProtoParseError, 400]
  make_http_error[:ClientError, 400]
  make_http_error[:ServerError, 500]

  make_http_error[:BadRequest, 400, ClientError]
  make_http_error[:Unauthorized, 401, ClientError]
  make_http_error[:PaymentRequired, 402, ClientError]
  make_http_error[:Forbidden, 403, ClientError]
  make_http_error[:NotFound, 404, ClientError]
  make_http_error[:MethodNotAllowed, 405, ClientError]
  make_http_error[:NotAcceptable, 406, ClientError]
  make_http_error[:ProxyAuthenticationRequired, 407, ClientError]
  make_http_error[:RequestTimeout, 408, ClientError]
  make_http_error[:Conflict, 409, ClientError]
  make_http_error[:Gone, 410, ClientError]
  make_http_error[:LengthRequired, 411, ClientError]
  make_http_error[:PreconditionFailed, 412, ClientError]
  make_http_error[:PayloadTooLarge, 413, ClientError]
  make_http_error[:RequestURITooLong, 414, ClientError]
  make_http_error[:UnsupportedMediaType, 415, ClientError]
  make_http_error[:RequestRangeNotSatisfiable, 416, ClientError]
  make_http_error[:ExpectationFailed, 417, ClientError]
  make_http_error[:ImATeapot, 418, ClientError]
  make_http_error[:MisdirectionRequest, 421, ClientError]
  make_http_error[:UnprocessableEntity, 422, ClientError]
  make_http_error[:Locked, 423, ClientError]
  make_http_error[:FailedDependency, 424, ClientError]
  make_http_error[:UpgradeRequired, 426, ClientError]
  make_http_error[:PreconditionRequired, 428, ClientError]
  make_http_error[:TooManyRequests, 429, ClientError]
  make_http_error[:RequestHeaderFieldsTooLarge, 431, ClientError]
  make_http_error[:UnavailableForLegalReasons, 451, ClientError]
  make_http_error[:ClientClosedRequest, 499, ClientError]

  make_http_error[:InternalServerError, 500, ServerError]
  make_http_error[:NotImplemented, 501, ServerError]
  make_http_error[:BadGateway, 502, ServerError]
  make_http_error[:ServiceUnavailable, 503, ServerError]
  make_http_error[:GatewayTimeout, 504, ServerError]
  make_http_error[:HttpVersionNotSupported, 505, ServerError]
  make_http_error[:VariantAlsoNegotiates, 506, ServerError]
  make_http_error[:InsufficientStorage, 507, ServerError]
  make_http_error[:LoopDetected, 508, ServerError]
  make_http_error[:NotExtended, 510, ServerError]
  make_http_error[:NetworkAuthenticationRequired, 511, ServerError]
  make_http_error[:NetworkConnectTimeoutError, 599, ServerError]
end
