module Rubeetup
  class RequestBuilder

    VERBS = [:create, :get, :edit, :delete]

    def initialize

    end

    def compose_request(name, args)
      #puts args.inspect
      #puts args.first
      #puts args[1] if args.length > 1

      validate_verb(name)
      verb, method = split(name)
      http_verb = determine_http_verb(verb)

      #@request = Request.new(http_verb, method, args[0], args[1])
    end

    def validate_verb(name)
      unless name =~ /^(#{VERBS.map {|verb| verb.to_s + '_'}.join('|')})/
        raise RequestError, <<-END.gsub(/^ {10}/, '')
          '#{name}' is an invalid request.
          The only available requests must begin with any of: #{VERBS.gsub('|', ', ')}
        END
      end
    end

    def split(name)
      pos = name =~ /_/
      [ name[0...pos].to_sym, name[(pos + 1)...name.length].to_sym ] if pos
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