module Rubeetup
  ##
  # Concrete implementation of a catalog
  # @note it respects the interface demanded by Rubeetup::RequestCatalog, and
  #   as such, it provides a module method +.requests+, and for each entry in the
  #   catalog there exists a Hash which can respond to +[:options]+ and +[:path]+
  #
  module MeetupCatalog
    extend Rubeetup::Utilities
    class << self
      ##
      # Returns a Hash including all the supported requests. Each entry in the hash
      # corresponds to a request, and it specifies both its +path+, and its <tt>required options</tt>.
      # @return [Hash{Symbol=>Hash{Symbol=>Lambda, Symbol=>Array<Symbol>}}]
      # @note Rubeetup automatically passes authentication options with +each+ request,
      #     and no request can even be initiated without it.
      #     Even though the required options for these requests omit this auth data,
      #     it is implied that it is indeed required for all the following requests
      #     to have it.
      #
      def requests
        # @note I've averaged times for both YAML and JSON, and JSON:
        #    For 200 runs:  YAML => 0.00315      JSON => 0.00027
        #    Well that just about does it...
        #YAML.load(File.read("#{catalog_dir}meetup_catalog.yaml"))

        hash = JSON.parse(File.read("#{catalog_dir}meetup_catalog.json"), symbolize_names: true)
        # Now transform all the required options into symbols
        hash.each {|_, val| val[:options] = collection_symbolyzer(val[:options]) }
      end
    end
  end
end
