require 'net/http/post/multipart'

module Rubeetup
  ##
  # Responsible for sending responses over an http connection
  #
  class RequestSender
    include Rubeetup::Utilities

    ##
    # Destination host
    #
    HOST = 'api.meetup.com'

    ##
    # @return [Net::HTTP] this Sender's http connection
    #
    attr_reader :http

    ##
    # @return [Symbol] this Sender's chosen request type
    #
    attr_reader :response_type

    ##
    # @return [Symbol] this Sender's chosen multipart handler
    #
    attr_reader :multipart_handler_type

    def initialize
      @http = Net::HTTP.new(HOST)
      @multipart_handler_type = Net::HTTP::Post::Multipart
      @response_type = Rubeetup::RequestResponse
    end

    ##
    # Performs a request and returns back the response
    # @param [Rubeetup::Request] request the request instance to be sent
    # @return [Array<Rubeetup::ResponseWrapper>] the request response
    #
    def get_response(request)
      response_type.new(fetch(request)).data
    end

    private

    def fetch(request)
      return multipart_post(request) if request.multipart
      # else proceed with url-encoded
      http.send_request(
        request.http_verb.upcase,
        request.method_path,
        stringify(request.options))
    end

    def multipart_post(request)
      encode_resources(request)
      http.request(multipart_handler_type.new(request.method_path,
                                              request.options))
    end

    def encode_resources(request)
      request.multipart.call(request.options)
    end
  end
end
