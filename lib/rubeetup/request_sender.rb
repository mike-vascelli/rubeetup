require 'net/http'

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

    def initialize
      @http = Net::HTTP.new(HOST)
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
      http.send_request(
        request.http_verb.upcase,
        request.method_path,
        stringify(request.options)
      )
    end
  end
end
