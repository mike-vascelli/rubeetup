module Rubeetup
  class RequestBuilder

    attr_reader :request

    def initialize
      @request = Request
    end

    def compose_request(name, args)
      klass = self.class
      verb = klass.get_verb(name)
      klass.validate_verb(verb)
      request.new(name: name, http_verb: klass.infer_http_verb(verb), options: args[0], version: args[1])
    end


    private

    VERBS = {create: :post, get: :get, edit: :post, delete: :delete}

    def self.get_verb(name)
      pos = (name =~ /_/)
      pos ? name[0...pos].to_sym : nil
    end

    def self.validate_verb(verb)
      valid_verbs = VERBS.keys
      unless valid_verbs.include? verb
        message = <<-DOC.gsub(/ {10}/, '')
          '#{verb}' is an invalid method.
          The only available requests must begin with any of: #{valid_verbs.join(', ')}
        DOC
        raise RequestError, message
      end
    end

    def self.infer_http_verb(verb)
      VERBS[verb]
    end
  end
end