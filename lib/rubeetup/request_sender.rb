require 'net/http'

module Rubeetup
  class RequestSender
    include Utilities

    HOST = 'api.meetup.com'

    attr_reader :http, :response_wrapper

    def initialize
      @http = Net::HTTP.new(HOST)
      @response_wrapper = RequestResponse
    end

    def get_response(request)
      response_wrapper.new(fetch(request)).data
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
