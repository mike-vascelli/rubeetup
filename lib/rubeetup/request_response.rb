require 'json'
require 'net/http'

module Rubeetup
  ##
  # Packages a response, and provides for its validation
  #
  class RequestResponse
    ##
    # @return [Net::HTTPResponse] response the raw response from the sender
    #
    attr_reader :response

    ##
    # @return [Hash{Symbol=>...}] parsed_body the JSON-parsed body of the response.
    #   It is a Hash with all the keys as Symbols
    #
    attr_reader :parsed_body

    ##
    # @param [Net::HTTPResponse] raw_data the raw response from the sender
    #
    def initialize(raw_data)
      @response = raw_data
      @parsed_body = JSON.parse(@response.body, symbolize_names: true)
    end

    ##
    # If the request was successful, then creates a collection of
    # Rubeetup::ResponseWrapper instances.
    # @return [Array<Rubeetup::ResponseWrapper>] a collection containing the response's data
    #
    def data
      fail Rubeetup::MeetupResponseError.new(self), error_message unless
        response.is_a? Net::HTTPSuccess
      collection = parsed_body[:results] || [parsed_body]
      collection.map {|elem| Rubeetup::ResponseWrapper.new(elem)}
    end

    # Consider implementing pagination
    #def prev; end
    #def next; end
    #def all; end # Calls #next until no more and returns all the results at once

    private

    ##
    # Reads the response's body for the URL used in making the request
    #
    def request_url
      meta = parsed_body[:meta]
      meta[:url] if meta
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
