module Rubeetup
  class RequestBuilder

    attr_reader :request

    def initialize
      @request = Request
    end

    def compose_request(name, args)
      verb, method = split(name)
      request.new(verb: verb, method: method, options: args[0], version: args[1])
    end

    def split(name)
      pos = (name =~ /_/)
      pos ? [ name[0...pos].to_sym, name[(pos + 1)...name.length].to_sym ] : [nil, nil]
    end
  end
end