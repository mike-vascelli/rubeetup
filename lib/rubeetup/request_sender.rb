require 'net/http'

module Rubeetup
  class RequestSender

    HOST = 'api.meetup.com'

    attr_reader :http, :response

    def initialize
      @http = Net::HTTP.new(HOST)
      @response = RequestResponse
    end

    def get_response(request)
      response.new(fetch(request))
    end


    private

    def fetch(request)
      http.send_request(request.http_verb.upcase, request.method_path, options)
    end
  end
end