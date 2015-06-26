module Rubeetup
  InvalidAuthenticationError = Class.new(StandardError)

  RequestError = Class.new(StandardError)

  CatalogError = Class.new(StandardError)

  class MeetupResponseError < StandardError
    attr_reader :response

    # The response will be a Rubeetup::RequestResponse instance
    # Use it to access the data in the response as you please
    def initialize(response)
      @response = response
    end
  end
end
