module Rubeetup
  class Request

    attr_reader :verb, :method, :options, :api_version, :sender

    def initialize(args = {})
      # FIRST VALIDATE THEN ASSIGN TO INSTANCES
      # USE A LAMBDA fOR EACH OPERATION AND A BIG HASH CONTAINING ALL THE KEYS BUT ENCODE THEM FIRST eg. createvenue: dfsdfsdfsfdf
      @verb = args[:verb]
      @method = args[:method]
      @options = args[:options]
      @api_version = args[:version] || 2
      @sender = RequestSender.new
      validate_request!
    end

    def execute!
      sender.get_response(self)
    end


    private

    VERBS = [:create, :get, :edit, :delete]

    def validate_request!
      validate_verb!
      #validate the rest
    end

    def validate_verb!
      unless VERBS.include? verb
        message = <<-END.gsub(/ {10}/, '')
          '#{verb}' is an invalid method.
          The only available requests must begin with any of: #{VERBS.join(', ')}
        END
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
  end
end