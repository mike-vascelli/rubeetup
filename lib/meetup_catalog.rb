require 'utilities'

module Rubeetup
  module MeetupCatalog
    extend Utilities

    # name is a symbol
    def find_in_catalog(name)
      @request_entry = MeetupCatalog.requests[name]
    end

    def required_options
      @request_entry || (fail CatalogError, self.class.error_message('options'))
      @request_entry[:options]
    end

    def request_path
      @request_entry || (fail CatalogError, self.class.error_message('path'))
      @request_entry[:path]
    end

    private

    def self.error_message(object)
      "Cannot find #{object}. Must first call: \
        MeetupCatalog#find_in_catalog('name')"
    end

    def self.requests
      @requests = {
        get_events: { path: ->(options) { "/2/events?#{stringify(options)}" },
                      options: [:event_id, :group_domain, :group_id,
                                :group_urlname, :member_id, :rsvp, :venue_id] }
      }
    end
  end
end
