module Rubeetup
  ##
  # @author Mike Vascelli <michele.vascelli@gmail.com>
  #
  # Requester instances perform requests for the user
  #
  class Requester
    include Rubeetup::Utilities

    ##
    # @return [Hash{Symbol=>String}] this Requester's auth data
    #
    attr_reader :auth

    ##
    # @return [Symbol] the chosen request builder
    #
    attr_reader :request_builder

    ##
    # @param [Hash{Symbol=>String}] args holds auth data to send with each request
    # @option args [String] :key the api key
    #
    def initialize(args)
      self.auth = args
      @request_builder = Rubeetup::RequestBuilder
    end

    ##
    # Sets auth data, and validates it.
    # @param [Hash{Symbol=>String}] args holds auth data to send with each request
    # @option args [String] :key the api key
    # @raise [Rubeetup::InvalidAuthenticationError] if the passed auth data is not a Hash,
    #   or if it does not include key: 'val'
    #
    def auth=(args)
      @auth = args
      validate_auth
    end


    ##
    # Performs the actual request, by dynamically creating a Request instance,
    # and by then executing it.
    # @param [Symbol] name request name
    # @param [Array<Hash{Symbol=>String}, ...>] args holds the request options
    # @return [Array<Rubeetup::ResponseWrapper>] the request response
    #
    def method_missing(name, *args)
      merge_auth(args)
      request = request_builder.compose_request(name, args)
      request.execute
    end

    private

    def validate_auth
      fail Rubeetup::InvalidAuthenticationError, 'Must respond to #merge' unless
        auth.respond_to? :merge
      fail Rubeetup::InvalidAuthenticationError, "Requires ---> {key: /[^\s]+/}" unless
        (val = auth[:key]) && present?(val)
    end

    # Operates on the memory referenced by args
    # @note should both auth, and args have the same keys, then the keys in auth
    #   will overwrite those in options. This guarantees that if the user
    #   includes api keys while sending a request, those will be ignored.
    #
    def merge_auth(args)
      options = args[0]
      args[0] = options.respond_to?(:merge) ? options.merge(auth) : auth
    end
  end
end
