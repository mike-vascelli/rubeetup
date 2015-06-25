require 'meetup_catalog'

module Rubeetup
  class Request

    include MeetupCatalog

    attr_reader :http_verb, :method_path, :options, :api_version, :sender

    def initialize(args = {})
      validate_request(args)
      @http_verb = args[:http_verb]
      @options = args[:options]
      @method_path = request_path.call(@options)
      @api_version = args[:version] || 2 # reflect on this one
      @sender = RequestSender.new
    end

    def execute
      sender.get_response(self)
    end


    private

    def validate_request(args)
      verify_existence(args[:name])
      validate_options(args[:options])
    end

    def verify_existence(name)
      unless find_in_catalog(name)
        message = <<-DOC.gsub(/ {10}/, '')
          '#{name}' is an invalid request.
          This request does not exist in the catalog of supported requests.
          Please consult the catalog or the provided documentation for the \
          complete list of requests.
        DOC
        raise RequestError, message
      end
    end

    def validate_options(options)
      required_keys = required_options
      unless options.keys.any? {|key| required_keys.include? key}
        message = <<-DOC.gsub(/ {10}/, '')
          '#{options.inspect}' does not include the required parameters.
          This request cannot be completed as is.
          Please consult the catalog or the provided documentation for the \
          complete list of requests, and their respective required parameters.
        DOC
        raise RequestError, message
      end
    end
  end
end