require 'utilities'

module Rubeetup
  # NOTE: This module expects to be mixed in to a class which implements
  # the instance method 'name'.
  module MeetupCatalog
    extend Utilities

    def is_in_catalog?
      catalog[name]
    end

    def required_options
      catalog[name][:options] || cry('options')
    end

    def request_path
      catalog[name][:path] || cry('path')
    end

    private

    def catalog
      @data ||= MeetupCatalog.requests
    end

    def cry(why)
      raise CatalogError, error_message(why)
    end

    def error_message(object)
      "Cannot find '#{object}' for the '#{name}' request."
    end

    # private module method

    def self.requests
      {
        get_events: { path: ->(options) { "/2/events?#{stringify(options)}" },
                      options: [:event_id, :group_domain, :group_id,
                                :group_urlname, :member_id, :rsvp, :venue_id] }
      }
    end
  end
end
