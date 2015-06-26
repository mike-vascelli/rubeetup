module Rubeetup
  class RequestBuilder
    attr_reader :request

    def initialize
      @request = Request
    end

    def compose_request(name, args)
      klass = self.class
      # NOTE: Not sure if I like this private class method crap...
      verb = klass.send(:get_verb, name)
      klass.send(:validate_verb, verb)
      request.new(
        name: name,
        http_verb: klass.send(:infer_http_verb, verb),
        options: args[0],
        version: args[1]
      )
    end

    class << self
      private

      def verbs
        { create: :post, get: :get, edit: :post, delete: :delete }
      end

      def get_verb(name)
        pos = (name =~ /_/)
        pos ? name[0...pos].to_sym : nil
      end

      def validate_verb(verb)
        valid_verbs = verbs.keys
        fail RequestError, error_message(verb, valid_verbs) unless
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
