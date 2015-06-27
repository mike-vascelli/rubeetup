require 'meetup_catalog'

module Rubeetup
  class Request
    include MeetupCatalog

    attr_reader :name, :http_verb, :method_path, :options, :api_version, :sender

    def initialize(args = {})
      @name = args[:name]
      @options = args[:options]
      validate_request
      @http_verb = args[:http_verb]
      @method_path = request_path.call(@options)
      @api_version = args[:version] || 2 # reflect on this one
      @sender = RequestSender.new
    end

    def execute
      sender.get_response(self)
    end

    private

    def validate_request
      verify_existence
      validate_options
    end

    def verify_existence
      fail RequestError, existence_message unless is_in_catalog?
    end

    def validate_options
      fail RequestError, options_message unless has_required_options?
    end

    def has_required_options?
      required_keys = required_options
      options.keys.any? { |key| required_keys.include? key }
    end

    def existence_message
      <<-DOC.gsub(/^ {8}/, '')
        The provided request => '#{name}' is an invalid request.
        This request does not exist in the catalog of supported requests.
        Please consult the catalog or the provided documentation for the
        complete list of requests.
      DOC
    end

    def options_message
      <<-DOC.gsub(/^ {8}/, '')
        The provided data => '#{options.inspect}' is missing one or more
        required parameters.
        This request cannot be completed as is.
        Please consult the catalog or the provided documentation for the
        complete list of requests, and their respective required parameters.
      DOC
    end
  end
end
