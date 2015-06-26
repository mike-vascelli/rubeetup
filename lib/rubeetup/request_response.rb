require 'json'
require 'net/http'

module Rubeetup
  class RequestResponse
    def initialize(raw_data)
      fail MeetupResponseError, self.class.send(:error_message, raw_data) unless
          raw_data.is_a? Net::HTTPSuccess
      @data = JSON.parse(raw_data.body, symbolize_names: true)
    end

    def data
      @data[:results] || [@data]
    end

    class << self
      private

      def error_message(data)
        "something wrong with response from Meetup: #{data.body}"
      end
    end
  end
end
