module Rubeetup
  class Request
    VERBS = [:create, :get, :edit, :delete]

    def initialize(args)
      #validate_request(args)
    end

    def validate_request(verb, method, args)
      validate_verb(verb)
      #validate the rest
    end

    def validate_verb(verb)
      unless VERBS.include? verb
        raise RequestError, <<-END.gsub(/^ {10}/, '')
          '#{verb}' is an invalid method.
          The only available requests must begin with any of: #{VERBS.join(', ')}
        END
      end
    end

    def execute

    end

  end
end