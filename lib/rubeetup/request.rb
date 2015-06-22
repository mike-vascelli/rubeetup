module Rubeetup
  class Request

    VERBS = [:create, :get, :edit, :delete]

    attr_reader :verb, :method, :options, :api_version, :sender

    def initialize(args = {})
      @verb = args[:verb]
      @method = args[:method]
      @options = args[:options]
      @api_version = args[:version] || 2
      @sender = #Http_Sender.new
      validate_request!
    end

    def validate_request!
      validate_verb!
      #validate the rest
    end

    def validate_verb!
      unless VERBS.include? verb
        message = <<-END.gsub(/^ {10}/, '')
          '#{verb}' is an invalid method.
          The only available requests must begin with any of: #{VERBS.join(', ')}
        END
        raise RequestError, message
      end
    end

    def execute!
      sender.send(self)
    end

  end
end