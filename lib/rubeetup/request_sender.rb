require 'net/http/post/multipart'

module Rubeetup
  ##
  # Responsible for sending responses over an http connection
  #
  class RequestSender
    include Rubeetup::Utilities

    ##
    # Destination host
    #
    HOST = 'api.meetup.com'
    MOST = 'https://api.meetup.com'

    ##
    # @return [Net::HTTP] this Sender's http connection
    #
    attr_reader :http

    ##
    # @return [Rubeetup::Request] this Sender's request job
    #
    attr_reader :request

    ##
    # @return [Net::HTTPResponse] the response data obtained from the request
    #
    attr_reader :response_data

    def initialize
      @http = Net::HTTP.new(HOST)
    end

    ##
    # Performs a request and returns back the response
    # @param [Rubeetup::Request] request the request instance to be sent
    # @return [Array<Rubeetup::ResponseWrapper>] the request response
    #
    def get_response(request)
      @request = request
      @response_data = fetch
      response_class.new(self).data
    end

    private

    def fetch
      request.http_verb == :post ? (req = post) : (req = get_or_delete)
      http.request(req)
    end

    def get_or_delete
      path = "#{request.method_path}?#{stringify(request.options)}"
      http_method_class.new(path)
    end

    def post
      request.multipart ? multipart_post : url_encoded_post
    end

    def url_encoded_post
      req = http_method_class.new(request.method_path)
      req.set_form_data(request.options)
      req
    end

    def multipart_post
      encode_resources
      http_method_class.new(request.method_path, request.options)
    end

    def encode_resources
      request.multipart.call(request.options)
    end

    def http_method_class
      class_name = request.http_verb.capitalize.to_s
      if request.multipart
        Net::HTTP::Post::Multipart
      else
        Net::HTTP.const_get(class_name.to_sym)
      end
    end

    def response_class
      Rubeetup::RequestResponse
    end

    def handler_class
      Typhoeus::Request
    end
  end
end
