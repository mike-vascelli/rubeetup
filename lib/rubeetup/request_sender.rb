module Rubeetup
  class RequestSender

    def initialize

    end

    def send(request)

    end

    #http_verb = infer_http_verb(verb)

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