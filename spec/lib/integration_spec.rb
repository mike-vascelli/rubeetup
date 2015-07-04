require 'spec_helper'

def printer
  Rubeetup::MeetupCatalog.requests.keys.each do |req|
    puts <<-DOC.gsub(/^ {6}/, '')
      it 'correctly handles :#{req}' do
        VCR.use_cassette('#{req}') do
          expect{@sender.#{req}()}.not_to raise_error
        end
      end

    DOC
  end
end

describe Rubeetup do
  before(:all) do
    @sender = Rubeetup.setup(key: api_key)
  end

  it 'correctly handles :get_open_events' do
    VCR.use_cassette('get_open_events') do
      #expect{@sender.get_open_events()}.not_to raise_error
    end
  end
=begin
  it 'correctly handles :get_concierge' do
    VCR.use_cassette('get_concierge') do
      expect{@sender.get_concierge()}.not_to raise_error
    end
  end

  it 'correctly handles :get_events' do
    VCR.use_cassette('get_events') do
      expect{@sender.get_events()}.not_to raise_error
    end
  end

  it 'correctly handles :create_event' do
    VCR.use_cassette('create_event') do
      expect{@sender.create_event()}.not_to raise_error
    end
  end

  it 'correctly handles :get_event' do
    VCR.use_cassette('get_event') do
      expect{@sender.get_event()}.not_to raise_error
    end
  end

  it 'correctly handles :edit_event' do
    VCR.use_cassette('edit_event') do
      expect{@sender.edit_event()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_event' do
    VCR.use_cassette('delete_event') do
      expect{@sender.delete_event()}.not_to raise_error
    end
  end

  it 'correctly handles :get_event_comments' do
    VCR.use_cassette('get_event_comments') do
      expect{@sender.get_event_comments()}.not_to raise_error
    end
  end

  it 'correctly handles :create_event_comment' do
    VCR.use_cassette('create_event_comment') do
      expect{@sender.create_event_comment()}.not_to raise_error
    end
  end

  it 'correctly handles :get_event_comment' do
    VCR.use_cassette('get_event_comment') do
      expect{@sender.get_event_comment()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_event_comment' do
    VCR.use_cassette('delete_event_comment') do
      expect{@sender.delete_event_comment()}.not_to raise_error
    end
  end

  it 'correctly handles :create_event_comment_flag' do
    VCR.use_cassette('create_event_comment_flag') do
      expect{@sender.create_event_comment_flag()}.not_to raise_error
    end
  end

  it 'correctly handles :create_event_comment_subscribe' do
    VCR.use_cassette('create_event_comment_subscribe') do
      expect{@sender.create_event_comment_subscribe()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_event_comment_subscribe' do
    VCR.use_cassette('delete_event_comment_subscribe') do
      expect{@sender.delete_event_comment_subscribe()}.not_to raise_error
    end
  end

  it 'correctly handles :create_event_comment_like' do
    VCR.use_cassette('create_event_comment_like') do
      expect{@sender.create_event_comment_like()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_event_comment_like' do
    VCR.use_cassette('delete_event_comment_like') do
      expect{@sender.delete_event_comment_like()}.not_to raise_error
    end
  end

  it 'correctly handles :get_event_comment_likes' do
    VCR.use_cassette('get_event_comment_likes') do
      expect{@sender.get_event_comment_likes()}.not_to raise_error
    end
  end

  it 'correctly handles :get_event_ratings' do
    VCR.use_cassette('get_event_ratings') do
      expect{@sender.get_event_ratings()}.not_to raise_error
    end
  end

  it 'correctly handles :create_event_rating' do
    VCR.use_cassette('create_event_rating') do
      expect{@sender.create_event_rating()}.not_to raise_error
    end
  end

  it 'correctly handles :create_attendance' do
    VCR.use_cassette('create_attendance') do
      expect{@sender.create_attendance()}.not_to raise_error
    end
  end

  it 'correctly handles :get_attendance' do
    VCR.use_cassette('get_attendance') do
      expect{@sender.get_attendance()}.not_to raise_error
    end
  end

  it 'correctly handles :create_event_payments' do
    VCR.use_cassette('create_event_payments') do
      expect{@sender.create_event_payments()}.not_to raise_error
    end
  end

  it 'correctly handles :create_watchlist' do
    VCR.use_cassette('create_watchlist') do
      expect{@sender.create_watchlist()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_watchlist' do
    VCR.use_cassette('delete_watchlist') do
      expect{@sender.delete_watchlist()}.not_to raise_error
    end
  end

  it 'correctly handles :get_boards' do
    VCR.use_cassette('get_boards') do
      expect{@sender.get_boards()}.not_to raise_error
    end
  end

  it 'correctly handles :get_discussions' do
    VCR.use_cassette('get_discussions') do
      expect{@sender.get_discussions()}.not_to raise_error
    end
  end

  it 'correctly handles :get_discussion_posts' do
    VCR.use_cassette('get_discussion_posts') do
      expect{@sender.get_discussion_posts()}.not_to raise_error
    end
  end

  it 'correctly handles :get_categories' do
    VCR.use_cassette('get_categories') do
      expect{@sender.get_categories()}.not_to raise_error
    end
  end

  it 'correctly handles :get_cities' do
    VCR.use_cassette('get_cities') do
      expect{@sender.get_cities()}.not_to raise_error
    end
  end

  it 'correctly handles :get_dashboard' do
    VCR.use_cassette('get_dashboard') do
      expect{@sender.get_dashboard()}.not_to raise_error
    end
  end

  it 'correctly handles :get_activity' do
    VCR.use_cassette('get_activity') do
      expect{@sender.get_activity()}.not_to raise_error
    end
  end

  it 'correctly handles :get_groups' do
    VCR.use_cassette('get_groups') do
      expect{@sender.get_groups()}.not_to raise_error
    end
  end

  it 'correctly handles :get_comments' do
    VCR.use_cassette('get_comments') do
      expect{@sender.get_comments()}.not_to raise_error
    end
  end

  it 'correctly handles :create_group_photo' do
    VCR.use_cassette('create_group_photo') do
      expect{@sender.create_group_photo()}.not_to raise_error
    end
  end

  it 'correctly handles :get_find_groups' do
    VCR.use_cassette('get_find_groups') do
      expect{@sender.get_find_groups()}.not_to raise_error
    end
  end

  it 'correctly handles :get_group' do
    VCR.use_cassette('get_group') do
      expect{@sender.get_group()}.not_to raise_error
    end
  end

  it 'correctly handles :edit_group' do
    VCR.use_cassette('edit_group') do
      expect{@sender.edit_group()}.not_to raise_error
    end
  end

  it 'correctly handles :create_group_topics' do
    VCR.use_cassette('create_group_topics') do
      expect{@sender.create_group_topics()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_group_topics' do
    VCR.use_cassette('delete_group_topics') do
      expect{@sender.delete_group_topics()}.not_to raise_error
    end
  end

  it 'correctly handles :get_recommended_groups' do
    VCR.use_cassette('get_recommended_groups') do
      expect{@sender.get_recommended_groups()}.not_to raise_error
    end
  end

  it 'correctly handles :create_recommended_groups_ignores' do
    VCR.use_cassette('create_recommended_groups_ignores') do
      expect{@sender.create_recommended_groups_ignores()}.not_to raise_error
    end
  end

  it 'correctly handles :get_similar_groups' do
    VCR.use_cassette('get_similar_groups') do
      expect{@sender.get_similar_groups()}.not_to raise_error
    end
  end

  it 'correctly handles :get_members' do
    VCR.use_cassette('get_members') do
      expect{@sender.get_members()}.not_to raise_error
    end
  end

  it 'correctly handles :get_member' do
    VCR.use_cassette('get_member') do
      expect{@sender.get_member()}.not_to raise_error
    end
  end

  it 'correctly handles :edit_member' do
    VCR.use_cassette('edit_member') do
      expect{@sender.edit_member()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_member_photo' do
    VCR.use_cassette('delete_member_photo') do
      expect{@sender.delete_member_photo()}.not_to raise_error
    end
  end

  it 'correctly handles :create_member_photo' do
    VCR.use_cassette('create_member_photo') do
      expect{@sender.create_member_photo()}.not_to raise_error
    end
  end

  it 'correctly handles :get_status' do
    VCR.use_cassette('get_status') do
      expect{@sender.get_status()}.not_to raise_error
    end
  end

  it 'correctly handles :get_notifications' do
    VCR.use_cassette('get_notifications') do
      expect{@sender.get_notifications()}.not_to raise_error
    end
  end

  it 'correctly handles :create_notifications_read' do
    VCR.use_cassette('create_notifications_read') do
      expect{@sender.create_notifications_read()}.not_to raise_error
    end
  end

  it 'correctly handles :get_oembed' do
    VCR.use_cassette('get_oembed') do
      expect{@sender.get_oembed()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_photo' do
    VCR.use_cassette('delete_photo') do
      expect{@sender.delete_photo()}.not_to raise_error
    end
  end

  it 'correctly handles :get_photo_comments' do
    VCR.use_cassette('get_photo_comments') do
      expect{@sender.get_photo_comments()}.not_to raise_error
    end
  end

  it 'correctly handles :create_photo_comment' do
    VCR.use_cassette('create_photo_comment') do
      expect{@sender.create_photo_comment()}.not_to raise_error
    end
  end

  it 'correctly handles :get_photo_albums' do
    VCR.use_cassette('get_photo_albums') do
      expect{@sender.get_photo_albums()}.not_to raise_error
    end
  end

  it 'correctly handles :get_photos' do
    VCR.use_cassette('get_photos') do
      expect{@sender.get_photos()}.not_to raise_error
    end
  end

  it 'correctly handles :create_photo_album' do
    VCR.use_cassette('create_photo_album') do
      expect{@sender.create_photo_album()}.not_to raise_error
    end
  end

  it 'correctly handles :create_photo' do
    VCR.use_cassette('create_photo') do
      expect{@sender.create_photo()}.not_to raise_error
    end
  end

  it 'correctly handles :get_profiles' do
    VCR.use_cassette('get_profiles') do
      expect{@sender.get_profiles()}.not_to raise_error
    end
  end

  it 'correctly handles :create_profile' do
    VCR.use_cassette('create_profile') do
      expect{@sender.create_profile()}.not_to raise_error
    end
  end

  it 'correctly handles :edit_profile' do
    VCR.use_cassette('edit_profile') do
      expect{@sender.edit_profile()}.not_to raise_error
    end
  end

  it 'correctly handles :get_profile' do
    VCR.use_cassette('get_profile') do
      expect{@sender.get_profile()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_profile' do
    VCR.use_cassette('delete_profile') do
      expect{@sender.delete_profile()}.not_to raise_error
    end
  end

  it 'correctly handles :create_member_approvals' do
    VCR.use_cassette('create_member_approvals') do
      expect{@sender.create_member_approvals()}.not_to raise_error
    end
  end

  it 'correctly handles :delete_member_approvals' do
    VCR.use_cassette('delete_member_approvals') do
      expect{@sender.delete_member_approvals()}.not_to raise_error
    end
  end

  it 'correctly handles :get_rsvps' do
    VCR.use_cassette('get_rsvps') do
      expect{@sender.get_rsvps()}.not_to raise_error
    end
  end

  it 'correctly handles :create_rsvp' do
    VCR.use_cassette('create_rsvp') do
      expect{@sender.create_rsvp()}.not_to raise_error
    end
  end

  it 'correctly handles :edit_rsvp' do
    VCR.use_cassette('edit_rsvp') do
      expect{@sender.edit_rsvp()}.not_to raise_error
    end
  end

  it 'correctly handles :get_rsvp' do
    VCR.use_cassette('get_rsvp') do
      expect{@sender.get_rsvp()}.not_to raise_error
    end
  end

  it 'correctly handles :get_topic_categories' do
    VCR.use_cassette('get_topic_categories') do
      expect{@sender.get_topic_categories()}.not_to raise_error
    end
  end

  it 'correctly handles :get_topics' do
    VCR.use_cassette('get_topics') do
      expect{@sender.get_topics()}.not_to raise_error
    end
  end

  it 'correctly handles :get_recommended_group_topics' do
    VCR.use_cassette('get_recommended_group_topics') do
      expect{@sender.get_recommended_group_topics()}.not_to raise_error
    end
  end

  it 'correctly handles :get_open_venues' do
    VCR.use_cassette('get_open_venues') do
      expect{@sender.get_open_venues()}.not_to raise_error
    end
  end

  it 'correctly handles :get_venues' do
    VCR.use_cassette('get_venues') do
      expect{@sender.get_venues()}.not_to raise_error
    end
  end

  it 'correctly handles :get_group_venues' do
    VCR.use_cassette('get_group_venues') do
      expect{@sender.get_group_venues()}.not_to raise_error
    end
  end

  it 'correctly handles :get_recommended_venues' do
    VCR.use_cassette('get_recommended_venues') do
      expect{@sender.get_recommended_venues()}.not_to raise_error
    end
  end

  it 'correctly handles :create_venue' do
    VCR.use_cassette('create_venue') do
      expect{@sender.create_venue()}.not_to raise_error
    end
  end



=begin

  it 'performs requests with no errors' do
    event = @sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'testolino', time: 1442041200000).first
    expect{@sender.delete_event(id: event.id)}.not_to raise_error
  end

  it 'performs photo upload with no errors' do
    #event = @sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'pic test')
    #expect{@sender.create_photo(event_id: event.first.id, photo: "#{test_files_folder}cat.png")}.not_to raise_error
  end
=end
end
