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
      catalog[name][:options]
    end

    def request_path
      catalog[name][:path]
    end

    private

    def catalog
      @data ||= Rubeetup::MeetupCatalog.send(:requests)
    end

    def self.requests
      {
        get_events: { path: ->(options) { "/2/events?#{stringify(options)}" },
                      options: [:event_id, :group_domain, :group_id,
                                :group_urlname, :member_id, :rsvp, :venue_id] }
      }
    end

    private_class_method :requests
  end
end
