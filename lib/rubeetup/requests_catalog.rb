require 'rubeetup/requests_lib/meetup_catalog'

module Rubeetup
  # NOTE: This module expects to be mixed in to a class which implements
  # the instance method 'name'.
  module RequestsCatalog
    def is_in_catalog?
      catalog[name]
    end

    def required_options
      catalog[name][:options]
    end

    def request_path
      catalog[name][:path]
    end

    private

    # Could be fitted to take an arg, or even an attribute, to decide which
    # catalog should be built dynamically...
    def catalog
      RequestsCatalog.send(:build_catalog)
    end

    def self.build_catalog
      @data ||= MeetupCatalog.requests
    end

    private_class_method :build_catalog
  end
end
