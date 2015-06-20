require 'utilities'

module Rubeetup
  class Requester
    include Utilities

    attr_reader :auth, :request_builder

    def initialize(args = {})
      self.auth = args
      @request_builder = RequestBuilder.new
    end

    def auth=(args = {})
      @auth = args
      validate_auth!
    end

    def validate_auth!
      raise InvalidAuthenticationError, 'Must respond to #merge' unless auth.respond_to? :merge
      raise InvalidAuthenticationError, "Requires ---> {api_key: /[^\s]+/}" unless
        (val = auth[:api_key]) && present?(val)
    end

    def method_missing(name, *args)
      # This operation will raise an error if request does not exist, or if args are missing
      args[0] = args[0].respond_to?(:merge) ? args[0].merge(auth) : auth
      request = request_builder.compose_request(name, args)
      request.execute
    end
  end
end