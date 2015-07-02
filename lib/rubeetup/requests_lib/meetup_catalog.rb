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
        {
          #####################################################################
          ################  EVENTS  ###########################################
          #####################################################################

          get_open_events: { path: ->(options) { "/2/open_events?#{stringify(options)}" },
                             options: [:category, :city, :country, :lat, :lon, :state,
                                       :text, :topic, :zip] },
          get_concierge:   { path: ->(options) { "/2/concierge?#{stringify(options)}" },
                             options: [] },
          get_events:      { path: ->(options) { "/2/events?#{stringify(options)}" },
                             options: [:event_id, :group_domain, :group_id,
                                       :group_urlname, :member_id, :rsvp, :venue_id] },

          # EVENT CRUD
          create_event:    { path: ->(_) { "/2/event" },
                             options: [[:group_id, :group_urlname, :name]] },
          get_event:       { path: ->(options) { "/2/event/#{options[:id]}?#{stringify(options)}" },
                             options: [:id] },
          edit_event:      { path: ->(options) { "/2/event/#{options[:id]}" },
                             options: [:id] },
          delete_event:    { path: ->(options) { "/2/event/#{options[:id]}" },
                             options: [:id] },


          get_event_comments: { path: ->(options) { "/2/event_comments?#{stringify(options)}" },
                                options: [:comment_id, :event_id, :group_id, :member_id] },


          # EVENT COMMENT CRD  NOTE!!! Edit is NOT supported
          create_event_comment: { path: ->(_) { "/2/event_comment" },
                                  options: [[:comment, :event_id, :in_reply_to]] },
          get_event_comment:    { path: ->(options) { "/2/event_comment/#{options[:id]}?#{stringify(options)}" },
                                  options: [:id] },
          delete_event_comment: { path: ->(options) { "/2/event_comment/#{options[:id]}" },
                                  options: [:id] },



          create_event_comment_flag: { path: ->(_) { "/2/event_comment_flag" },
                                       options: [:comment_id] },



          create_event_comment_subscribe: { path: ->(options) { "/2/event_comment_subscribe/#{options[:comment_id]}" },
                                            options: [:comment_id] },
          delete_event_comment_subscribe: { path: ->(options) { "/2/event_comment_subscribe/#{options[:comment_id]}" },
                                            options: [:comment_id] },



          create_event_comment_like: { path: ->(options) { "/2/event_comment_like/#{options[:comment_id]}" },
                                       options: [:comment_id] },
          delete_event_comment_like: { path: ->(options) { "/2/event_comment_like/#{options[:comment_id]}" },
                                       options: [:comment_id] },



          get_event_comment_likes: { path: ->(options) { "/2/event_comment_likes?#{stringify(options)}" },
                                     options: [:comment_id] },



          get_event_ratings: { path: ->(options) { "/2/event_ratings?#{stringify(options)}" },
                               options: [:event_id] },



          create_event_rating: { path: ->(_) { "/2/event_rating" },
                                 options: [[:event_id, :rating]] },



          create_attendance: { path: ->(options) { "/#{options[:urlname]}/events/#{options[:event_id]}/attendance" },
                               options: [[:event_id, :urlname], :member, :status] },
          get_attendance:    { path: ->(options) { "/#{options[:urlname]}/events/#{options[:event_id]}/attendance?#{stringify(options)}" },
                               options: [[:event_id, :urlname]] },



          create_event_payments: { path: ->(options) { "/#{options[:urlname]}/events/#{options[:event_id]}/payments" },
                                   options: [[:event_id, :urlname], :member, :amount] },



          create_watchlist: { path: ->(options) { "/#{options[:urlname]}/events/#{options[:event_id]}/watchlist" },
                              options: [[:event_id, :urlname]] },
          delete_watchlist: { path: ->(options) { "/#{options[:urlname]}/events/#{options[:event_id]}/watchlist" },
                              options: [[:event_id, :urlname]] },


          #
          # @note The +abuse+ section of the Meetup API requires OAuth tokens, so we will defer their implementation at a later time
          #

          #
          # @note The +batch+ section of the Meetup API requires OAuth tokens, so we will defer their implementation at a later time
          #


          #####################################################################
          ################  BOARDS  ###########################################
          #####################################################################

          get_boards:           { path: ->(options) { "/#{options[:urlname]}/boards?#{stringify(options)}" },
                                  options: [:urlname] },
          get_discussions:      { path: ->(options) { "/#{options[:urlname]}/boards/#{options[:board_id]}/discussions?#{stringify(options)}" },
                                  options: [[:urlname, :board_id]] },
          get_discussion_posts: { path: ->(options) { "/#{options[:urlname]}/boards/#{options[:board_id]}/discussions/#{options[:discussion_id]}?#{stringify(options)}" },
                                  options: [[:urlname, :board_id, :discussion_id]] },

          #####################################################################
          ################  CATEGORIES  #######################################
          #####################################################################

          get_categories: { path: ->(options) { "/2/categories?#{stringify(options)}" },
                            options: [] },


          #####################################################################
          ################  CITIES  ###########################################
          #####################################################################

          get_cities: { path: ->(options) { "/2/cities?#{stringify(options)}" },
                            options: [] },


          #####################################################################
          ################  DASHBOARD  ########################################
          #####################################################################

          get_dashboard: { path: ->(options) { "/dashboard?#{stringify(options)}" },
                        options: [] },


          #####################################################################
          ################  FEEDS  ############################################
          #####################################################################

          get_activity: { path: ->(options) { "/activity?#{stringify(options)}" },
                        options: [] },


          #####################################################################
          ################  GROUPS  ###########################################
          #####################################################################

          get_groups: { path: ->(options) { "/2/groups?#{stringify(options)}" },
                        options: [:category_id, [:country, :city, :state], :domain,
                                  :group_id, :group_urlname, [:lat, :lon], :member_id,
                                  :organizer_id, :topic, [:topic, :groupnum], :zip] },


          get_comments: { path: ->(options) { "/comments?#{stringify(options)}" },
                          options: [:group_id, :group_urlname, [:topic, :groupnum]] },

          # @note If authenticating with OAuth, no parameters in
          #     the multipart form data should be included in the signature base string
          create_group_photo: { path: ->(_) { "/2/group_photo" },
                                options: [[:group_id, :photo], [:group_urlname, :photo]],
                                multipart: true},


          get_find_groups: { path: ->(options) { "/find/groups?#{stringify(options)}" },
                             options: [] },


          get_group:  { path: ->(options) { "/#{options[:group_urlname]}?#{stringify(options)}" },
                        options: [:group_urlname] },
          edit_group: { path: ->(options) { "/#{options[:group_urlname]}" },
                        options: [:group_urlname] },


          create_group_topics: { path: ->(options) { "/#{options[:group_urlname]}/topics" },
                                 options: [:group_urlname, :topic_id] },
          delete_group_topics: { path: ->(options) { "/#{options[:group_urlname]}/topics" },
                                 options: [:group_urlname, :topic_id] },


          get_recommended_groups:            { path: ->(options) { "/recommended/groups?#{stringify(options)}" },
                                               options: [] },
          create_recommended_groups_ignores: { path: ->(options) { "/recommended/groups/ignores/#{options[:group_urlname]}" },
                                               options: [:group_urlname] },


          get_similar_groups: { path: ->(options) { "/#{options[:urlname]}/similar_groups?#{stringify(options)}" },
                                options: [:urlname] },


          #####################################################################
          ################  MEMBERS  ##########################################
          #####################################################################

          get_members:  { path: ->(options) { "/2/members?#{stringify(options)}" },
                          options: [:group_id, :group_urlname, :member_id, :service, [:topic, :groupnum]] },


          get_member:   { path: ->(options) { "/2/member/#{options[:id]}?#{stringify(options)}" },
                          options: [:id] },
          edit_member:  { path: ->(options) { "/2/member/#{options[:id]}" },
                          options: [:id] },


          delete_member_photo: { path: ->(options) { "/2/member_photo/#{options[:id]}" },
                                 options: [:id] },
          # @note If authenticating with OAuth, no parameters in
          #     the multipart form data should be included in the signature base string
          create_member_photo: { path: ->(_) { "/2/member_photo" },
                                 options: [:photo],
                                 multipart: true },



          #####################################################################
          ################  NOTIFICATIONS  ####################################
          #####################################################################

          get_status:  { path: ->(_) { "/status" },
                          options: [] },


          #####################################################################
          ################  NOTIFICATIONS  ####################################
          #####################################################################

          get_notifications:         { path: ->(options) { "/notifications?#{stringify(options)}" },
                                       options: [] },

          create_notifications_read: { path: ->(_) { "/notifications/read" },
                                       options: [] },


          #####################################################################
          ################  OEMBED  ###########################################
          #####################################################################

          get_oembed:  { path: ->(options) { "/oembed?#{stringify(options)}" },
                         options: [:url] },


          #####################################################################
          ################  PHOTO  ############################################
          #####################################################################

          delete_photo: { path: ->(options) { "/2/photo/#{options[:id]}" },
                          options: [:id] },


          get_photo_comments: { path: ->(options) { "/2/photo_comments?#{stringify(options)}" },
                                options: [:photo_id] },


          create_photo_comment: { path: ->(_) { "/2/photo_comment" },
                                  options: [[:photo_id, :comment]] },


          get_photo_albums: { path: ->(options) { "/2/photo_albums?#{stringify(options)}" },
                              options: [:photo_album_id, :event_id, :group_id] },


          get_photos: { path: ->(options) { "/2/photos?#{stringify(options)}" },
                        options: [:event_id, :group_id, :group_urlname,
                                  :member_id, :photo_album_id, :photo_id, :tagged] },

          create_photo_album: { path: ->(_) { "/2/photo_album" },
                                options: [[:group_id, :title]] },

          # @note If authenticating with OAuth, no parameters in
          #     the multipart form data should be included in the signature base string
          create_event_photo: { path: ->(_) { "/2/photo" },
                                options: [[:photo, :event_id], [:photo, :photo_album_id]],
                                multipart: true },


          #####################################################################
          ################  PROFILES  #########################################
          #####################################################################

          get_profiles: { path: ->(options) { "/2/profiles?#{stringify(options)}" },
                          options: [:group_id, :group_urlname, :member_id, [:topic, :groupnum]] },

          # @note  An intro and answers may be required based on the group the
          #      member is joining. To find out if a group requires an intro or
          #      answers to questions, query for the group through one of the
          #      Groups methods providing setting the fields parameter to
          #      join_info and inspecting the join_info in the results
          #
          create_profile: { path: ->(_) { "/2/profile" },
                            options: [:group_id, :group_urlname] },
          edit_profile:   { path: ->(options) { "/2/profile/#{options[:group_id]}/#{options[:member_id]}" },
                            options: [[:group_id, :member_id]] },
          get_profile:    { path: ->(options) { "/2/profile/#{options[:group_id]}/#{options[:member_id]}?#{stringify(options)}" },
                            options: [[:group_id, :member_id]] },
          delete_profile: { path: ->(options) { "/2/profile/#{options[:group_id]}/#{options[:member_id]}" },
                            options: [[:group_id, :member_id]] },


          create_member_approvals: { path: ->(options) { "/#{options[:urlname]}/member/approvals" },
                                     options: [:urlname] },
          delete_member_approvals: { path: ->(options) { "/#{options[:urlname]}/member/approvals" },
                                     options: [:urlname] },


          #####################################################################
          ################  RSVP  #############################################
          #####################################################################

          get_rsvps: { path: ->(options) { "/2/rsvps?#{stringify(options)}" },
                       options: [:event_id] },

          # @note If the event requires payment you are required to send an
          #      "agree_to_refund" parameter set to the true or false.
          create_rsvp: { path: ->(_) { "/2/rsvp" },
                         options: [[:event_id, :rsvp]] },
          # @note If the event requires payment you are required to send an
          #      "agree_to_refund" parameter set to the true or false.
          edit_rsvp:   { path: ->(_) { "/2/rsvp" },
                         options: [[:event_id, :rsvp]] },
          get_rsvp:    { path: ->(options) { "/2/rsvp/#{options[:id]}?#{stringify(options)}" },
                         options: [:id] },


          #
          #
          # @note I'm skipping STREAMS for the moment.
          #
          #


          #####################################################################
          ################  TOPICS  ###########################################
          #####################################################################

          get_topic_categories: { path: ->(options) { "/2/topic_categories?#{stringify(options)}" },
                                  options: [] },


          get_topics: { path: ->(options) { "/topics?#{stringify(options)}" },
                        options: [:member_id, :name, :search, :topic] },


          get_recommended_group_topics: { path: ->(options) { "/recommended/group_topics?#{stringify(options)}" },
                                          options: [:text, :other_topics] },



          #####################################################################
          ################  VENUES  ###########################################
          #####################################################################

          get_open_venues: { path: ->(options) { "/2/open_venues?#{stringify(options)}" },
                             options: [:country, :city, :state, :group_urlname,
                                       :lat, :lon, :text, :zip] },


          # @note You can use either group_urlname or group_id to filter by groups but not both.
          #
          get_venues: { path: ->(options) { "/2/venues?#{stringify(options)}" },
                        options: [:group_id, :group_urlname, :venue_id, :event_id] },


          get_group_venues: { path: ->(options) { "/#{:urlname}/venues?#{stringify(options)}" },
                              options: [:urlname] },


          get_recommended_venues: { path: ->(options) { "/recommended/venues?#{stringify(options)}" },
                                    options: [] },


          create_venue: { path: ->(options) { "/#{options[:urlname]}/venues" },
                          options: [:address_1, :country, :city, :state, :name] }
        }
      end
    end
  end
end
