require 'json'

module Rubeetup
  ##
  # Packages a response, and provides for its validation
  #
  class RequestResponse
    include Rubeetup::Utilities

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
    # @return [Rubeetup::Request] the request which caused this response
    #
    attr_reader :request

    ##
    # @param [Net::HTTPResponse] raw_data the raw response from the sender
    #
    def initialize(sender)
      @response = sender.response_data
      @request = sender.request
      body =  @response.body
      @parsed_body = blank?(body) ? [] : parse(body)
    end

    ##
    # If the request was successful, then creates a collection of
    # Rubeetup::ResponseWrapper instances.
    # @return [Array<Rubeetup::ResponseWrapper>] a collection containing the response's data
    #
    def data
      fail error_class.new(self), error_message unless
        #response.success?  #TYPHOEUS
        success?            #Net::HTTP
      collection = collectionize(parsed_body)
      collection.map {|elem| wrapper_class.new(elem)}
    end

    # Consider implementing pagination
    #def prev; end
    #def next; end
    #def all; end # Calls #next until no more and returns all the results at once

    private

    def success?
      response.is_a? Net::HTTPSuccess
    end

    def error_class
      Rubeetup::MeetupResponseError
    end

    def wrapper_class
      Rubeetup::ResponseWrapper
    end

    def collectionize(data)
      return data if data.is_a? Array
      data[:results] || [data]
    end

    def parse(body)
      begin
        JSON.parse(body, symbolize_names: true)
      rescue
        body
      end
    end

    def error_message
      <<-DOC.gsub(/^ {8}/, '')
        An error was encountered while processing the following request:
        #{request}
        Here's some information to describe the error, and/or its causes:
        #{parsed_body}
      DOC
    end
  end
end
