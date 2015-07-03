module Rubeetup
  ##
  # Provides some miscellaneous methods for mix-ins
  #
  module Utilities
    ##
    # Determines if the object is not blank
    # (see #blank?)
    #
    def present?(obj)
      !blank?(obj)
    end

    ##
    # @param [Object] obj an object
    # @return [Boolean] whether the object is blank as per Ruby Active Support
    #
    def blank?(obj)
      obj.nil? || obj == false || obj.empty? || obj =~ /^\s+$/
    end

    ##
    # Generates a string of key values to include in URL's
    # @param [Hash{Symbol=>String}] options holds options for a request
    # @return [String] a sringified representation of a Hash of options
    #
    def stringify(options)
      return '' unless options.respond_to? :map
      options.map { |key, val| "#{key}=#{val}" if key && val }.compact.join('&')
    end

    ##
    # Transforms the strings into a possibly nested collection, into symbols
    # @note For speed and simplicity no error checking is performed
    # @param [Array<String, Array...>] array a possibly recursive collection of strings
    # @return [Array<Symbol, Array...>] a possibly recursive collection of Symbols
    #
    def collection_symbolyzer(array)
      array.map {|elem| elem.is_a?(String) ? elem.to_sym : collection_symbolyzer(elem)}
    end

    ##
    # Gives you the dir where all the request catalogs should be stored
    # @return [String] the directory where you should store request catalogs
    #
    def catalog_dir
      'lib/rubeetup/requests_lib/'
    end
  end
end

