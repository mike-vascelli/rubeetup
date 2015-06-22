module Rubeetup
  class RequestBuilder

    attr_reader :request

    def initialize
      @request = Request
    end

    def compose_request(name, args)
      verb, method = split(name)
      http_verb = determine_http_verb(verb)
      request.new(verb: http_verb, method: method, options: args[0], version: args[1])
    end

    def split(name)
      pos = (name =~ /_/)
      pos ? [ name[0...pos].to_sym, name[(pos + 1)...name.length].to_sym ] : [nil, nil]
    end

    def determine_http_verb(verb)
      case verb
        when :delete then :delete
        when :get then :get
        when :edit then :post
        when :create then :post
        else :invalid
      end
    end

  end
end