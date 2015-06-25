require 'utilities'

module Rubeetup
  module MeetupCatalog

    include Utilities

    # name is a symbol
    def find_in_catalog(name)
      @request_entry = MeetupCatalog.requests[name]
    end

    def required_options
      raise CatalogError, 'Cannot find options. Must first call: #find_in_catalog' unless @request_entry
      @request_entry[:options]
    end

    def request_path
      raise CatalogError, 'Cannot find path. Must first call: #find_in_catalog' unless @request_entry
      @request_entry[:path]
    end


    private

    def self.requests
      @requests = {
        get_events: {path: lambda {|options| "/2/events?#{stringify(options)}"},
                     options: [:event_id, :group_domain, :group_id, :group_urlname, :member_id, :rsvp, :venue_id]}



      }
    end


  end
end