module Rubeetup
  module MeetupCatalog
    extend Rubeetup::Utilities

    def self.requests
      #byebug
      {
        get_open_events: { path: ->(options) { "/2/open_events?#{stringify(options)}" },
                           options: [:category, :city, :country, :lat, :lon, :state,
                                     :text, :topic, :zip] },
        get_concierge: { path: ->(options) { "/2/concierge?#{stringify(options)}" },
                         options: [] },
        get_events: { path: ->(options) { "/2/events?#{stringify(options)}" },
                      options: [:event_id, :group_domain, :group_id,
                                :group_urlname, :member_id, :rsvp, :venue_id] },

        # EVENT CRUD
        create_event: { path: ->(_) { "/2/event" },
                        options: [[:group_id, :group_urlname, :name]] },
        get_event: { path: ->(options) { "/2/event/#{options[:id]}?#{stringify(options)}" },
                     options: [:id] },
        edit_event: { path: ->(options) { "/2/event/#{options[:id]}" },
                      options: [:id] },
        delete_event: { path: ->(options) { "/2/event/#{options[:id]}" },
                        options: [:id] },


        get_event_comments: { path: ->(options) { "/2/event_comments?#{stringify(options)}" },
                              options: [:comment_id, :event_id, :group_id, :member_id] },

        # EVENT COMMENT CRUD
        create_event_comment: { path: ->(_) { "/2/event_comment" },
                                options: [[:comment, :event_id, :in_reply_to]] },
        get_event_comment: { path: ->(options) { "/2/event_comment/#{options[:id]}?#{stringify(options)}" },
                             options: [:id] },
        edit_event_comment: { path: ->(options) { "/2/event_comment/#{options[:id]}" },
                              options: [:id] },
        delete_event_comment: { path: ->(options) { "/2/event_comment/#{options[:id]}" },
                                options: [:id] },





      }
    end
  end
end
