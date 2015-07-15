module Rubeetup
  ##
  # Simple wrapper to allow the use of method missing in order provide fancier
  # RequestResponse's attributes access.
  #
  class ResponseWrapper
    ##
    # @param [Hash{Symbol=> ...}] data hash of response data
    #
    def initialize(data = {})
      @hash = data
    end

    ##
    # It captures messages passed on this object, and only responds to messages
    # for which the @hash can provide a non-nil value.
    #
    def method_missing(name, *args)
      if name == :[]
        key = args.first
        @hash.include?(key) ? @hash[key] :
          (raise ArgumentError, "#{key} is not a valid argument")
      elsif @hash.include? name
        @hash[name]
      elsif @hash.respond_to? name
        @hash.send name
      else
        super
      end
    end

    ##
    # Wraps itself over a Hash, and it does so recursively as long as it finds
    # nested Hashes
    # @note it modifies the input data
    # @param [Hash{Symbol=> ...}] data hash of response data
    #
    def self.wrapperize!(data)
      if data.is_a? Hash
        obj = Rubeetup::ResponseWrapper.new(data)
        data.each do |key, val|
          data[key] = wrapperize!(val)
        end
        obj
      else
        data
      end
    end
  end
end