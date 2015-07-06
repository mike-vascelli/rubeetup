require 'spec_helper'

if api_key
  describe Rubeetup do
    before(:all) do
      @sender = Rubeetup.setup(key: api_key)
    end

    it 'correctly handles :get_open_events' do
      VCR.use_cassette('get_open_events') do
        expect{@sender.get_open_events(zip: '94608')}.not_to raise_error
      end
    end

    it 'correctly handles :get_concierge' do
      VCR.use_cassette('get_concierge') do
        expect{@sender.get_concierge(zip: '94608')}.not_to raise_error
      end
    end

    it 'correctly handles :get_events' do
      VCR.use_cassette('get_events') do
        expect{@sender.get_events(group_urlname: testing_group_urlname)}.not_to raise_error
      end
    end

    it 'correctly handles :create_event' do
      VCR.use_cassette('create_event') do
        expect{@sender.create_event(group_id: testing_group_id,
                                    group_urlname: testing_group_urlname,
                                    name: 'test')}.not_to raise_error
      end
    end

    it 'correctly handles :get_event' do
      VCR.use_cassette('get_event---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                     group_urlname: testing_group_urlname,
                                     name: 'test').first
      end
      VCR.use_cassette('get_event') do
        expect{@sender.get_event(id: @event.id)}.not_to raise_error
      end
    end


    it 'correctly handles :edit_event' do
      VCR.use_cassette('edit_event---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('edit_event') do
        expect{@sender.edit_event(id: @event.id)}.not_to raise_error
      end
    end

    it 'correctly handles :delete_event' do
      VCR.use_cassette('delete_event---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('delete_event') do
        expect{@sender.delete_event(id: @event.id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_event_comments' do
      VCR.use_cassette('get_event_comments---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('get_event_comments') do
        expect{@sender.get_event_comments(event_id: @event.id)}.not_to raise_error
      end
    end

    it 'correctly handles :create_event_comment' do
      VCR.use_cassette('create_event_comment---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_event_comment') do
        expect{@sender.create_event_comment(event_id: @event.id,
                                            comment: 'test')}.not_to raise_error
      end
    end

    it 'correctly handles :get_event_comment' do
      VCR.use_cassette('get_event_comment---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('get_event_comment---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('get_event_comment') do
        expect{@sender.get_event_comment(id: @comment.event_comment_id)}.not_to raise_error
      end
    end

    it 'correctly handles :delete_event_comment' do
      VCR.use_cassette('delete_event_comment---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('delete_event_comment---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('delete_event_comment') do
        expect{@sender.delete_event_comment(id: @comment.event_comment_id)}.not_to raise_error
      end
    end

    it 'correctly handles :create_event_comment_flag' do
      VCR.use_cassette('create_event_comment_flag---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_event_comment_flag---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('create_event_comment_flag') do
        begin
          @sender.create_event_comment_flag(comment_id: @comment.event_comment_id)
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body[:details]).to eq('Not authorized to flag comment')
        end
      end
    end

    it 'correctly handles :create_event_comment_subscribe' do
      VCR.use_cassette('create_event_comment_subscribe---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_event_comment_subscribe---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('create_event_comment_subscribe') do
        expect{@sender.create_event_comment_subscribe(comment_id: @comment.event_comment_id)}.not_to raise_error
      end
    end

    it 'correctly handles :delete_event_comment_subscribe' do
      VCR.use_cassette('delete_event_comment_subscribe---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('delete_event_comment_subscribe---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('delete_event_comment_subscribe---create_event_comment_subscribe') do
        @sender.create_event_comment_subscribe(comment_id: @comment.event_comment_id)
      end
      VCR.use_cassette('delete_event_comment_subscribe') do
        expect{@sender.delete_event_comment_subscribe(comment_id: @comment.event_comment_id)}.not_to raise_error
      end
    end

    it 'correctly handles :create_event_comment_like' do
      VCR.use_cassette('create_event_comment_like---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_event_comment_like---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('create_event_comment_like') do
        expect{@sender.create_event_comment_like(comment_id: @comment.event_comment_id)}.not_to raise_error
      end
    end

    it 'correctly handles :delete_event_comment_like' do
      VCR.use_cassette('delete_event_comment_like---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('delete_event_comment_like---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('delete_event_comment_like---create_event_comment_like') do
        expect{@sender.create_event_comment_like(comment_id: @comment.event_comment_id)}.not_to raise_error
      end
      VCR.use_cassette('delete_event_comment_like') do
        expect{@sender.delete_event_comment_like(comment_id: @comment.event_comment_id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_event_comment_likes' do
      VCR.use_cassette('get_event_comment_likes---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('get_event_comment_likes---create_event_comment') do
        @comment = @sender.create_event_comment(event_id: @event.id,
                                                comment: 'test').first
      end
      VCR.use_cassette('get_event_comment_likes') do
        expect{@sender.get_event_comment_likes(comment_id: @comment.event_comment_id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_event_ratings' do
      VCR.use_cassette('get_event_ratings---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('get_event_ratings') do
        expect{@sender.get_event_ratings(event_id: @event.id)}.not_to raise_error
      end
    end

    it 'correctly gets a 500 response from the server for :create_event_rating because the event has not ended yet' do
      VCR.use_cassette('create_event_rating---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_event_rating') do
        begin
          @sender.create_event_rating(event_id: @event.id, rating: '2')
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body).to eq('internal server error')
        end
      end
    end

    it 'correctly gets a 400 error for :create_attendance because the event has not already started' do
      VCR.use_cassette('create_attendance---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_attendance') do
        begin
          @sender.create_attendance(urlname: testing_group_urlname,
                                    event_id: @event.id,
                                    member: '184911456',
                                    status: 'attended')
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body[:errors].first[:message]).to eq('Event must have started')
        end
      end
    end

    it 'correctly gets a 400 error for :get_attendance because the event has not already started' do
      VCR.use_cassette('get_attendance---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('get_attendance') do
        begin
          @sender.get_attendance(urlname: testing_group_urlname,
                                 event_id: @event.id)
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body[:errors].first[:message]).to eq('Event must have started')
        end
      end
    end

    it 'correctly handles :create_event_payments' do
      VCR.use_cassette('create_event_payments---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_event_payments') do
        expect{@sender.create_event_payments(urlname: testing_group_urlname,
                                             event_id: @event.id,
                                             member: testing_member_id,
                                             amount: '2')}.not_to raise_error
      end
    end

    it 'correctly handles :create_watchlist' do
      VCR.use_cassette('create_watchlist---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('create_watchlist') do
        expect{@sender.create_watchlist(urlname: testing_group_urlname,
                                        event_id: @event.id)}.not_to raise_error
      end
    end

    it 'correctly handles :delete_watchlist' do
      VCR.use_cassette('delete_watchlist---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'test').first
      end
      VCR.use_cassette('delete_watchlist---create_watchlist') do
        @sender.create_watchlist(urlname: testing_group_urlname,
                                 event_id: @event.id)
      end
      VCR.use_cassette('delete_watchlist') do
        expect{@sender.delete_watchlist(urlname: testing_group_urlname,
                                        event_id: @event.id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_boards' do
      VCR.use_cassette('get_boards') do
        expect{@sender.get_boards(urlname: testing_group_urlname)}.not_to raise_error
      end
    end

    it 'correctly handles :get_discussions' do
      VCR.use_cassette('get_discussions') do
        expect{@sender.get_discussions(board_id: testing_board_id,
                                       urlname: testing_group_urlname)}.not_to raise_error
      end
    end

    it 'correctly handles :get_discussion_posts' do
      VCR.use_cassette('get_discussion_posts---get_discussions') do
        @discussion = @sender.get_discussions(board_id: testing_board_id,
                                              urlname: testing_group_urlname).first
      end
      VCR.use_cassette('get_discussion_posts') do
        expect{@sender.get_discussion_posts(board_id: testing_board_id,
                                            discussion_id: "#{@discussion.id}",
                                            urlname: testing_group_urlname)}.not_to raise_error
      end
    end

    it 'correctly handles :get_categories' do
      VCR.use_cassette('get_categories') do
        expect{@sender.get_categories}.not_to raise_error
      end
    end

    it 'correctly handles :get_cities' do
      VCR.use_cassette('get_cities') do
        expect{@sender.get_cities}.not_to raise_error
      end
    end

    it 'correctly handles :get_dashboard' do
      VCR.use_cassette('get_dashboard') do
        expect{@sender.get_dashboard}.not_to raise_error
      end
    end

    it 'correctly handles :get_activity' do
      VCR.use_cassette('get_activity') do
        expect{@sender.get_activity}.not_to raise_error
      end
    end

    it 'correctly handles :get_groups' do
      VCR.use_cassette('get_groups') do
        expect{@sender.get_groups(zip: '94608')}.not_to raise_error
      end
    end

    it 'correctly handles :get_comments' do
      VCR.use_cassette('get_comments') do
        expect{@sender.get_comments(group_urlname: 'Meetup-API-Testing')}.not_to raise_error
      end
    end

    it 'correctly gets a 401 error for :create_group_photo given that we are not authorized to create picture photos' do
      VCR.use_cassette('create_group_photo') do
        begin
          @sender.create_group_photo(group_urlname: 'Meetup-API-Testing',
                                     photo: "#{test_files_folder}cat.png")
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body[:problem]).to eq('You are not authorized to make that request')
        end
      end
    end

    it 'correctly handles :get_find_groups' do
      VCR.use_cassette('get_find_groups') do
        expect{@sender.get_find_groups}.not_to raise_error
      end
    end

    it 'correctly handles :get_group' do
      VCR.use_cassette('get_group') do
        expect{@sender.get_group(group_urlname: 'Meetup-API-Testing')}.not_to raise_error
      end
    end

    it 'correctly handles :edit_group' do
      VCR.use_cassette('edit_group') do
        expect{@sender.edit_group(group_urlname: 'Meetup-API-Testing')}.not_to raise_error
      end
    end

    it 'correctly gets an error for :create_group_topics since we are not authorized to create topics for this group' do
      VCR.use_cassette('create_group_topics') do
        begin
          @sender.create_group_topics(group_urlname: 'Meetup-API-Testing',
                                      topic_id: testing_topic_id)
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body[:errors].first[:code]).to eq('add_topics_error')
        end
      end
    end

    it 'correctly gets an error for :delete_group_topics since we are not authorized to delete topics for this group' do
      VCR.use_cassette('delete_group_topics') do
        begin
          @sender.delete_group_topics(group_urlname: 'Meetup-API-Testing',
                                      topic_id: testing_topic_id)
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body[:errors].first[:code]).to eq('remove_topics_error')
        end
      end
    end

    it 'correctly handles :get_recommended_groups' do
      VCR.use_cassette('get_recommended_groups') do
        expect{@sender.get_recommended_groups}.not_to raise_error
      end
    end

    it 'correctly handles :create_recommended_groups_ignores' do
      VCR.use_cassette('create_recommended_groups_ignores') do
        expect{@sender.create_recommended_groups_ignores(group_urlname: 'Meetup-API-Testing')}.not_to raise_error
      end
    end

    it 'correctly handles :get_similar_groups' do
      VCR.use_cassette('get_similar_groups') do
        expect{@sender.get_similar_groups(urlname: 'Meetup-API-Testing')}.not_to raise_error
      end
    end

    it 'correctly handles :get_members' do
      VCR.use_cassette('get_members') do
        expect{@sender.get_members(group_urlname: 'Meetup-API-Testing')}.not_to raise_error
      end
    end

    it 'correctly handles :get_member' do
      VCR.use_cassette('get_member') do
        expect{@sender.get_member(id: testing_member_id)}.not_to raise_error
      end
    end

    it 'correctly gets an error from :edit_member because this request can only be done with TLS but we dont support it' do
      VCR.use_cassette('edit_member') do
        begin
          @sender.edit_member(id: testing_member_id)
        rescue Rubeetup::MeetupResponseError => e
          expect(e.response.parsed_body[:details]).to eq('Please use https for this method and authorization')
        end
      end
    end

    it 'correctly handles :create_member_photo' do
      VCR.use_cassette('create_member_photo') do
        expect{@sender.create_member_photo(photo: "#{test_files_folder}cat.png")}.not_to raise_error
      end
    end

    it 'correctly handles :delete_member_photo' do
      VCR.use_cassette('delete_member_photo---create_member_photo') do
        @pic = @sender.create_member_photo(photo: "#{test_files_folder}cat.png").first
      end
      VCR.use_cassette('delete_member_photo') do
        expect{@sender.delete_member_photo(id: @pic.member_photo_id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_status' do
      VCR.use_cassette('get_status') do
        expect{@sender.get_status}.not_to raise_error
      end
    end

    it 'correctly handles :get_notifications' do
      VCR.use_cassette('get_notifications') do
        expect{@sender.get_notifications}.not_to raise_error
      end
    end

    it 'correctly handles :create_notifications_read' do
      VCR.use_cassette('create_notifications_read') do
        expect{@sender.create_notifications_read(since_id: '0')}.not_to raise_error
      end
    end

    it 'correctly handles :get_oembed' do
      VCR.use_cassette('get_oembed') do
        expect{@sender.get_oembed(url: 'http://www.meetup.com/ny-tech')}.not_to raise_error
      end
    end

    it 'correctly handles :delete_photo' do
      VCR.use_cassette('delete_photo---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('delete_photo---create_photo') do
        @pic = @sender.create_photo(event_id: @event.id,
                                    photo: "#{test_files_folder}cat.png").first
      end
      VCR.use_cassette('delete_photo') do
        expect{@sender.delete_photo(id: @pic.event_photo_id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_photo_comments' do
      VCR.use_cassette('get_photo_comments---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('get_photo_comments---create_photo') do
        @pic = @sender.create_photo(event_id: @event.id,
                                    photo: "#{test_files_folder}cat.png").first
      end
      VCR.use_cassette('get_photo_comments') do
        expect{@sender.get_photo_comments(photo_id: @pic.event_photo_id)}.not_to raise_error
      end
    end

    it 'correctly handles :create_photo_comment' do
      VCR.use_cassette('get_photo_comments---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('get_photo_comments---create_photo') do
        @pic = @sender.create_photo(event_id: @event.id,
                                    photo: "#{test_files_folder}cat.png").first
      end
      VCR.use_cassette('create_photo_comment') do
        expect{@sender.create_photo_comment(photo_id: @pic.event_photo_id,
                                            comment: 'test')}.not_to raise_error
      end
    end

    it 'correctly handles :get_photo_albums' do
      VCR.use_cassette('get_photo_albums') do
        expect{@sender.get_photo_albums(group_id: testing_group_id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_photos' do
      VCR.use_cassette('get_photos') do
        expect{@sender.get_photos(group_id: testing_group_id)}.not_to raise_error
      end
    end

    it 'correctly handles :create_photo_album' do
      VCR.use_cassette('create_photo_album') do
        begin
          @sender.create_photo_album(group_id: testing_group_id,
                                     title: 'test')
        rescue StandardError => e
          expect(e.response.parsed_body[:details]).to eq('You must have organizer privileges to create a new photo album.')
        end
      end
    end

    it 'correctly handles :create_photo' do
      VCR.use_cassette('create_photo---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('create_photo') do
        expect{@sender.create_photo(event_id: @event.id,
                                    photo: "#{test_files_folder}cat.png")}.not_to raise_error
      end
    end

    it 'correctly handles :get_profiles' do
      VCR.use_cassette('get_profiles') do
        expect{@sender.get_profiles(group_urlname: testing_group_urlname)}.not_to raise_error
      end
    end

    it 'correctly gets error for :create_profile given that I am already a member of the testing group' do
      VCR.use_cassette('create_profile') do
        begin
          @sender.create_profile(group_urlname: testing_group_urlname)
        rescue StandardError => e
          expect(e.response.parsed_body[:details]).to eq('already member of group')
        end
      end
    end

    it 'correctly handles :edit_profile' do
      VCR.use_cassette('edit_profile') do
        expect{@sender.edit_profile(group_id: testing_group_id,
                                    member_id: testing_member_id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_profile' do
      VCR.use_cassette('get_profile') do
        expect{@sender.get_profile(group_id: testing_group_id,
                                   member_id: testing_member_id)}.not_to raise_error
      end
    end

    it 'correctly gets an error for :delete_profile given that I dont want to remove myself from the testing group so I gave a fake member_id' do
      VCR.use_cassette('delete_profile') do
        begin
          @sender.delete_profile(group_id: testing_group_id,
                                 member_id: '0')
        rescue StandardError => e
          expect(e.response.parsed_body[:details]).to eq('The resource you have requested can not be found')
        end
      end
    end

    it 'correctly gets an error for :create_member_approvals given that we dont organize the testing group' do
      VCR.use_cassette('create_member_approvals') do
        begin
          @sender.create_member_approvals(urlname: testing_group_urlname)
        rescue StandardError => e
          expect(e.response.parsed_body[:errors][0][:message]).to eq('you do not organize this Meetup')
        end
      end
    end

    it 'correctly gets an error for :delete_member_approvals given that we dont organize the testing group' do
      VCR.use_cassette('delete_member_approvals') do
        begin
          @sender.delete_member_approvals(urlname: testing_group_urlname)
        rescue StandardError => e
          expect(e.response.parsed_body[:errors][0][:message]).to eq('you do not organize this group')
        end
      end
    end

    it 'correctly handles :get_rsvps' do
      VCR.use_cassette('get_rsvps---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('get_rsvps') do
        expect{@sender.get_rsvps(event_id: @event.id)}.not_to raise_error
      end
    end

    it 'correctly handles :create_rsvp' do
      VCR.use_cassette('create_rsvp---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('create_rsvp') do
        expect{@sender.create_rsvp(event_id: @event.id,
                                   rsvp: 'yes')}.not_to raise_error
      end
    end

    it 'correctly handles :edit_rsvp' do
      VCR.use_cassette('edit_rsvp---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('edit_rsvp') do
        expect{@sender.edit_rsvp(event_id: @event.id,
                                 rsvp: 'yes')}.not_to raise_error
      end
    end

    it 'correctly handles :get_rsvp' do
      VCR.use_cassette('get_rsvp---create_event') do
        @event = @sender.create_event(group_id: testing_group_id,
                                      group_urlname: testing_group_urlname,
                                      name: 'testo').first
      end
      VCR.use_cassette('get_rsvp---get_rsvps') do
        @rsvp = @sender.get_rsvps(event_id: @event.id).first
      end
      VCR.use_cassette('get_rsvp') do
        expect{@sender.get_rsvp(id: @rsvp.rsvp_id)}.not_to raise_error
      end
    end

    it 'correctly handles :get_topic_categories' do
      VCR.use_cassette('get_topic_categories') do
        expect{@sender.get_topic_categories}.not_to raise_error
      end
    end

    it 'correctly handles :get_topics' do
      VCR.use_cassette('get_topics') do
        expect{@sender.get_topics(topic: 'nature')}.not_to raise_error
      end
    end

    it 'correctly handles :get_recommended_group_topics' do
      VCR.use_cassette('get_recommended_group_topics') do
        expect{@sender.get_recommended_group_topics(text: 'nature')}.not_to raise_error
      end
    end

    it 'correctly handles :get_open_venues' do
      VCR.use_cassette('get_open_venues') do
        expect{@sender.get_open_venues(zip: '94608')}.not_to raise_error
      end
    end

    it 'correctly handles :get_venues' do
      VCR.use_cassette('get_venues') do
        expect{@sender.get_venues(group_urlname: testing_group_urlname)}.not_to raise_error
      end
    end

    it 'correctly handles :get_recommended_venues' do
      VCR.use_cassette('get_recommended_venues') do
        expect{@sender.get_recommended_venues}.not_to raise_error
      end
    end

    it 'correctly handles :create_venue' do
      VCR.use_cassette('create_venue') do
        expect{@sender.create_venue(group_urlname: testing_group_urlname,
                                    address_1: '150 Vine st.',
                                    country: 'US',
                                    city: 'Los Angeles',
                                    state: 'CA',
                                    name: 'plaza')}.not_to raise_error
      end
    end

    it 'correctly handles :get_group_venues' do
      VCR.use_cassette('get_group_venues') do
        expect{@sender.get_group_venues(urlname: testing_group_urlname)}.not_to raise_error
      end
    end
  end
else
  puts 'The api key is not configured. Integration tests cannot run. Check out spec/spec_helper.rb at line 23 for hints'
end
