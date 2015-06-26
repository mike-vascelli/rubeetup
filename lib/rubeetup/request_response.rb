require 'json'
require 'net/http'

module Rubeetup
  class RequestResponse
    attr_reader :response

    def initialize(raw_data)
      @response = raw_data
      @data = JSON.parse(raw_data.body, symbolize_names: true)
    end

    def data
      fail MeetupResponseError.new(self), error_message unless
        response.is_a? Net::HTTPSuccess
      @data[:results] || [@data]
    end

    private

    def error_message
      <<-DOC.gsub(/^ {8}/, '')
        An error was encountered while processing your request:
        #{@data}
      DOC
    end
  end
end
