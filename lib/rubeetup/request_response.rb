require 'json'
require 'net/http'

module Rubeetup
  class RequestResponse
    attr_reader :response, :parsed_body

    def initialize(raw_data)
      @response = raw_data
      @parsed_body = JSON.parse(@response.body, symbolize_names: true)
    end

    def data
      fail MeetupResponseError.new(self), error_message unless
        response.is_a? Net::HTTPSuccess
      parsed_body[:results] || [parsed_body]
    end

    # Consider implementing pagination
    #def prev; end
    #def next; end
    #def all; end # Calls #next until no more and returns all the results at once

    private

    def request_url
      parsed_body[:meta][:url]
    end

    def error_message
      <<-DOC.gsub(/^ {8}/, '')
        An error was encountered while processing the following request:
        #{request_url}
        Here's some information to describe the error, and/or its causes:
        #{parsed_body}
      DOC
    end
  end
end
