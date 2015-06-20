require 'utilities'

module Rubeetup
  class Requester
    include Utilities

    attr_reader :auth

    def initialize(args = {})
      self.auth = args
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

    def method_missing(request, *args)

    end
  end
end