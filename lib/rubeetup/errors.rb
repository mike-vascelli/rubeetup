module Rubeetup
  ##
  # Raised when the user attempts to create an instance of Requester with
  # invalid auth data
  #
  InvalidAuthenticationError = Class.new(StandardError)

  ##
  # Raised when the user attempts to create an instance of Request, but the
  # request either does not exist, or it has one or more missing arguments
  #
  RequestError = Class.new(StandardError)

  ##
  # Custom Error to wrap Rubeetup::RequestResponse objects in case of error
  # while performing a request
  #
  class MeetupResponseError < StandardError

    ##
    # @return [Rubeetup::RequestResponse] the failed request's response
    #
    attr_reader :response

    ##
    # @param [Rubeetup::RequestResponse] response the failed request's response
    #
    def initialize(response)
      @response = response
    end
  end
end
