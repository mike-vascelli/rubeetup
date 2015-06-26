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

    def method_missing(name, *args)
      merge_auth(args)
      # This operation will raise an error if request does not exist,
      # or if args are missing
      request = request_builder.compose_request(name, args)
      request.execute
    end

    private

    def validate_auth
      fail InvalidAuthenticationError, 'Must respond to #merge' unless
        auth.respond_to? :merge
      fail InvalidAuthenticationError, "Requires ---> {key: /[^\s]+/}" unless
        (val = auth[:key]) && present?(val)
    end

    # Operates on the memory referenced by args
    def merge_auth(args)
      first_arg = args[0]
      args[0] = first_arg.respond_to?(:merge) ? auth.merge(first_arg) : auth
    end
  end
end
