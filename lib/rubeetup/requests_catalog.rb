require 'rubeetup/requests_lib/meetup_catalog'

module Rubeetup
  ##
  # Provides an interface to an abstract catalog of all the supported requests.
  # The concrete catalogs are provided in the +rubeetup/requests_lib+ folder,
  # and they are fetched by #build_catalog
  # @note This module expects to be mixed in to a class which implements
  #   the instance method +#name+.
  #
  module RequestsCatalog
    ##
    # @return [Boolean] whether a +name+ entry exists in the catalog
    #
    def is_in_catalog?
      catalog[name]
    end

    ##
    # Reads the +name+ entry in the catalog and then gets its required parameters
    # @note this module expects a concrete catalog whose entries can respond to +[:options]+
    # @return [Array<Symbol>] the list of all the required parameters
    #
    def required_options
      catalog[name][:options]
    end

    ##
    # Reads the +name+ entry in the catalog and then gets its lambda to compute the request's path
    # @note this module expects a concrete catalog whose entries can respond to +[:path]+
    # @return [Lambda] the lambda expression to compute the path for the request
    #
    def request_path
      catalog[name][:path]
    end

    private

    # Could be fitted to take an arg, or even an attribute, to decide which
    # catalog should be built dynamically...
    def catalog
      Rubeetup::RequestsCatalog.send(:build_catalog)
    end

    def self.build_catalog
      @data ||= Rubeetup::MeetupCatalog.requests
    end

    private_class_method :build_catalog
  end
end
