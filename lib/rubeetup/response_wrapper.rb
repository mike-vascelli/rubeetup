module Rubeetup
  ##
  # Simple wrapper to allow the use of method missing in order provide fancier
  # RequestResponse's attributes access.
  #
  class ResponseWrapper
    ##
    # @param [Hash{Symbol=> ...}] data hash of response data
    #
    def initialize(data)
      @hash = data
    end

    ##
    # It captures messages passed on this object, and only responds to messages
    # for which the @hash can provide a non-nil value.
    #
    def method_missing(name, *args)
      if name == :[]
        key = args.first
        @hash.include?(key) ? @hash[key] : super
      elsif @hash.include? name
        @hash[name]
      else
        super
      end
    end
  end
end