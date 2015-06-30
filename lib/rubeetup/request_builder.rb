module Rubeetup
  ##
  # Allows a Requester object to compose a Request instance with the passed data
  #
  module RequestBuilder
    class << self
      ##
      # Creates an instance of the chosen request type
      # @note only preliminary error checking on the request is performed here.
      # @param [Symbol] name the request's name
      # @param [Hash{Symbol=>String}] args holds the request's options
      # @return [Rubeetup::Request] the newly created Request instance
      #
      def compose_request(name, args)
        verb = get_verb(name)
        validate_verb(verb)
        request_type.new(
            name: name,
            http_verb: infer_http_verb(verb),
            options: args.first
        )
      end

      private

      def request_type
        Rubeetup::Request
      end

      def verbs
        { create: :post, get: :get, edit: :post, delete: :delete }
      end

      ##
      # Parses the request name, and attempts to split it around the leftmost
      # underscore char. If the name is properly formed, then the left half
      # is the verb of the request
      # @param [Symbol] name the request name
      # @return [Symbol] if name contains the required underscore char
      # @return [nil] if name is invalid
      #
      def get_verb(name)
        pos = (name =~ /_/)
        pos ? name[0...pos].to_sym : nil
      end

      def validate_verb(verb)
        valid_verbs = verbs.keys
        fail Rubeetup::RequestError, error_message(verb, valid_verbs) unless
          valid_verbs.include? verb
      end

      def error_message(verb, valid_verbs)
        <<-DOC.gsub(/^ {10}/, '')
          '#{verb}' is an invalid method.
          The only available requests must begin with any of:
          #{valid_verbs.join(', ')}
          Followed by underscore, and a Meetup request name.
          Consult the documentation for a complete list of available requests.
        DOC
      end

      def infer_http_verb(verb)
        verbs[verb]
      end
    end
  end
end
