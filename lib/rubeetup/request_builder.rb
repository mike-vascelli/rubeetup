module Rubeetup
  class RequestBuilder

    attr_reader :request

    def initialize
      @request = Request
    end

    def compose_request(name, args)
      verb = get_verb(name)
      validate_verb!(verb)
      request.new(name: name, http_verb: infer_http_verb(verb), options: args[0], version: args[1])
    end


    private

    VERBS = [:create, :get, :edit, :delete]

    def get_verb(name)
      pos = (name =~ /_/)
      pos ? name[0...pos].to_sym : nil
    end

    def validate_verb!(verb)
      unless VERBS.include? verb
        message = <<-DOC.gsub(/ {10}/, '')
          '#{verb}' is an invalid method.
          The only available requests must begin with any of: #{VERBS.join(', ')}
        DOC
        raise RequestError, message
      end
    end

    def infer_http_verb(verb)
      case verb
        when :delete then :delete
        when :get then :get
        when :edit then :post
        when :create then :post
        else :invalid
      end
    end

=begin
    def split(name)
      pos = (name =~ /_/)
      pos ? [ name[0...pos].to_sym, name[(pos + 1)...name.length].to_sym ] : [nil, nil]
    end
=end
  end
end