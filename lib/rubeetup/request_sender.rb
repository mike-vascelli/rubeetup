require 'net/http'

module Rubeetup
  class RequestSender

    HOST = 'api.meetup.com'

    attr_reader :http

    def initialize
      @http = Net::HTTP.new(HOST)
    end

    def get_response(request)
      fetch(request)
      # here do all the parsing that you want
      # create an object called Response
    end


    private

    def fetch(request)
      #http_verb = infer_http_verb(request.verb)
      options = stringify(request.options)
      puts options
      http.send_request(http_verb.upcase, '/2/events/?' + options, options)
    end

    def stringify(options)
      options.map {|key, val| "#{key}=#{val}"}.join('&') if options.respond_to? :map
    end


  end
end