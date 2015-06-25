require 'utilities'

module Rubeetup
  class Requester
    include Utilities

    attr_reader :auth, :request_builder

    def initialize(args)
      self.auth = args
      @request_builder = RequestBuilder.new
    end

    def auth=(args)
      @auth = args
      validate_auth
    end

    def validate_auth
      raise InvalidAuthenticationError, 'Must respond to #merge' unless auth.respond_to? :merge
      raise InvalidAuthenticationError, "Requires ---> {key: /[^\s]+/}" unless
        (val = auth[:key]) && present?(val)
    end

    def method_missing(name, *args)
      merge_auth(args)
      # This operation will raise an error if request does not exist, or if args are missing
      request = request_builder.compose_request(name, args)
      request.execute
    end

    def merge_auth(args)
      first_arg = args[0]
      args[0] = first_arg.respond_to?(:merge) ? first_arg.merge(auth) : auth
    end
  end
end