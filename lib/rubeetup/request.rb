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
      fail RequestError, self.class.send(:existence_message, name) unless
        find_in_catalog(name)
    end

    def validate_options(options)
      required_keys = required_options
      fail RequestError, self.class.send(:options_message, options) unless
        options.keys.any? { |key| required_keys.include? key }
    end

    def self.existence_message(name)
      <<-DOC.gsub(/^ {8}/, '')
        The provided request => '#{name}' is an invalid request.
        This request does not exist in the catalog of supported requests.
        Please consult the catalog or the provided documentation for the
        complete list of requests.
      DOC
    end

    def self.options_message(options)
      <<-DOC.gsub(/^ {8}/, '')
        The provided data => '#{options.inspect}' is missing one or more
        required parameters.
        This request cannot be completed as is.
        Please consult the catalog or the provided documentation for the
        complete list of requests, and their respective required parameters.
      DOC
    end

    private_class_method :existence_message, :options_message
  end
end
