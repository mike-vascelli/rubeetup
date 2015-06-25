require 'net/http'
require 'utilities'

module Rubeetup
  class RequestSender
    include Utilities

    HOST = 'api.meetup.com'

    attr_reader :http, :response

    def initialize
      @http = Net::HTTP.new(HOST)
      @response = RequestResponse
    end

    def get_response(request)
      response.new(fetch(request)).data
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
