require 'set'

module Rubeetup
  ##
  # Represents API requests. Provides for their own validation and execution
  #
  class Request
    include Rubeetup::RequestsCatalog
    include Rubeetup::Utilities

    ##
    # @return [Symbol] name the name of the request as input by the user
    #
    attr_reader :name

    ##
    # @return [Symbol] http_verb the http_verb for the request
    #
    attr_reader :http_verb

    ##
    # @return [String] method_path the path of the Meetup API resource
    #
    attr_reader :method_path

    ##
    # @return [Hash{Symbol=>String}] options holds the request's options
    #
    attr_reader :options

    ##
    # @return [Rubeetup::Sender] sender the request's chosen sender
    #
    attr_reader :sender

    ##
    # @return [Lambda] multipart if present it contains the multipart POST logic
    #
    attr_reader :multipart

    ##
    # @param [Hash{Symbol=>String}] args holds the request's data
    # @option args [Symbol] :name the full request's name
    # @option args [Hash{Symbol=>String}] :options holds the request's options
    # @option args [Symbol] :http_verb the request's http_verb
    #
    def initialize(args = {})
      @name = args[:name]
      @options = args[:options]
      validate_request
      @http_verb = args[:http_verb]
      @method_path = request_path.call(@options)
      @multipart = request_multipart
      @sender = Rubeetup::RequestSender.new
    end

    ##
    # Completes this request
    # @return [Array<Rubeetup::ResponseWrapper>] the request's response
    #
    def execute
      sender.get_response(self)
    end

    ##
    # For debugging purposes
    #
    def to_s
      <<-DOC.gsub(/^ {8}/, '')
        \nREQUEST
        name => #{name}
        verb => #{http_verb}
        path => #{method_path}
        options => #{options.inspect}\n
      DOC
    end

    private

    def validate_request
      verify_existence
      validate_options
    end

    def verify_existence
      fail error_class, existence_message unless is_in_catalog?
    end

    def validate_options
      fail error_class, options_message unless has_all_required_options?
    end

    ##
    # Uses sets to make sure that there is at least a set of required parameters
    # which is a subset of the arguments passed to the request
    # @return [Boolean] whether all the required arguments have been passed
    #
    def has_all_required_options?
      required_keys_sets = required_options.map do |elem|
        elem.respond_to?(:to_set) ? elem.to_set : Set[elem]
      end
      return true if required_keys_sets.empty?
      option_keys_set = options.keys.to_set
      required_keys_sets.any? { |set| set.subset? option_keys_set }
    end

    def existence_message
      <<-DOC.gsub(/^ {8}/, '')
        The provided request => '#{name}' is an invalid request.
        This request does not exist in the catalog of supported requests.
        Please consult rubeetup/requests_lib/meetup_catalog.rb, or the provided
        documentation for the complete list of requests.
      DOC
    end

    def options_message
      <<-DOC.gsub(/^ {8}/, '')
        This request cannot be completed as is.
        The provided arguments => '#{options.inspect}' miss one or more
        required parameters.
        The request '#{name}' requires the following parameters:
        #{required_options_message}
        Please consult rubeetup/requests_lib/meetup_catalog.rb, or the provided
        documentation for the complete list of requests, and their respective
        required parameters.
      DOC
    end

    def required_options_message
      str = ''
      required_options.each {|opt| str << opt.inspect + " OR "}
      str[0...-4]
    end

    def error_class
      Rubeetup::RequestError
    end
  end
end
