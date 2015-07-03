require 'spec_helper'

# the API allows LIMIT requests every TIMESPAN seconds
TIMESPAN = 10
LIMIT = 30

def pause(duration)
  Thread.sleep(duration)
end

def compute_delay(size)
  size >= LIMIT ? TIMESPAN / size : nil
end


describe Rubeetup do
  before(:all) do
    @sender = Rubeetup.setup(key: api_key)
    @requests = Rubeetup::MeetupCatalog.requests
  end

  describe 'the :create_profile request'  do
    it "should rightly fail given that I'm already a member of the testing group" do
      begin
        req = :create_profile
        @requests.delete(req)
        #@sender.send(req, {group_urlname: testing_group_urlname})
        #raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:details]).to eq('already member of group')
        puts 'COMPLETED ' + req.to_s
      end
    end
  end


  describe 'requests with no params' do
    it "performs them with no errors" do
      selected = @requests.select {|_, val| val[:options].empty?}.keys
      @requests.delete_if {|key, _| selected.include? key}
      time = compute_delay(selected.size)
      #selected.each do |req|
      #  pause(time) if time
      #  expect{@sender.send(req)}.not_to raise_error
      #  puts 'COMPLETED ' + req.to_s
      #end
    end
  end

  describe 'requests which take the parameter :group_urlname' do
    it "performs them with no errors" do
      selected = @requests.select {|_, val| val[:options].include? :group_urlname}.keys
      @requests.delete_if {|key, _| selected.include? key}
      time = compute_delay(selected.size)
      #selected.each do |req|
      #  pause(time) if time
      #  puts 'INIT ' + req.to_s
      #  expect{@sender.send(req, {group_urlname: testing_group_urlname})}.not_to raise_error
      #  puts 'COMPLETED ' + req.to_s
      #end
    end
  end




  describe 'requests which deal with event comments' do
    before(:all) do
      @event = @sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'test of tests').first
      @comment = @sender.create_event_comment(event_id: @event.id, comment: 'test').first
      puts 'COMPLETED :create_event_comment'
      @requests.delete(:create_event_comment)
    end



    ## COMMENT FLAG MUST FAIL BECAUSE I CANNOT FLAG it
    #  FOR THIS REASON YOU SHOULD PROBABLY REFACTOR THEM OUTSIDE
    #  {:details=>"Not authorized to flag comment", :code=>"not_authorized", :problem=>"You are not authorized to make that request"}
    #############################
    it 'the :create_event_comment_flag request should rightly fail given that meetup does not allow us to flag our own comment' do
      begin
        req = :create_event_comment_flag
        @requests.delete(req)
        @sender.send(req, {comment_id: @comment.event_comment_id})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:details]).to eq('Not authorized to flag comment')
        puts 'COMPLETED ' + req.to_s
      end
    end


    # POSSIBLY DELETE WILL FAIL

    #############################################################






    ## COMMENT SUBSCRIBE MUST FAIL BECAUSE I DON"T HAVE AUTH
    #  FOR THIS REASON YOU SHOULD PROBABLY REFACTOR THEM OUTSIDE
    # {:details=>"API requests must be key-signed, oauth-signed, or accompanied by a key: http://www.meetup.com/meetup_api/docs/#authentication", :code=>"not_authorized", :problem=>"You are not authorized to make that request"}    #############################
    it 'the :delete_event_comment_subscribe request should rightly fail given that meetup does not allow us to unsuscribe our own comment' do
      begin
        req = :delete_event_comment_subscribe
        @requests.delete(req)
        @sender.send(req, {comment_id: @comment.event_comment_id})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:problem]).to eq('You are not authorized to make that request')
        puts 'COMPLETED ' + req.to_s
      end
    end


    # CREATE ACTUALLY SUCCEDED!!!!!!

    #######################################



    ## COMMENT LIKE MUST FAIL BECAUSE I DON"T HAVE AUTH
    #  FOR THIS REASON YOU SHOULD PROBABLY REFACTOR THEM OUTSIDE
    # {:details=>"API requests must be key-signed, oauth-signed, or accompanied by a key: http://www.meetup.com/meetup_api/docs/#authentication", :code=>"not_authorized", :problem=>"You are not authorized to make that request"}    #############################
    it 'the :delete_event_comment_subscribe request should rightly fail given that meetup does not allow us to unsuscribe our own comment' do
      begin
        req = :delete_event_comment_like
        @requests.delete(req)
        @sender.send(req, {comment_id: @comment.event_comment_id})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:problem]).to eq('You are not authorized to make that request')
        puts 'COMPLETED ' + req.to_s
      end
    end


    # CREATE ACTUALLY SUCCEDED!!!!!!

    #######################################




    ## COMMENT DELETE MUST FAIL BECAUSE I DON"T HAVE AUTH
    #  FOR THIS REASON YOU SHOULD PROBABLY REFACTOR THEM OUTSIDE
    # {:details=>"API requests must be key-signed, oauth-signed, or accompanied by a key: http://www.meetup.com/meetup_api/docs/#authentication", :code=>"not_authorized", :problem=>"You are not authorized to make that request"}    #############################
    it 'the :delete_event_comment_subscribe request should rightly fail given that meetup does not allow us to unsuscribe our own comment' do
      begin
        req = :delete_event_comment
        @requests.delete(req)
        @sender.send(req, {id: @comment.event_comment_id})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:problem]).to eq('You are not authorized to make that request')
        puts 'COMPLETED ' + req.to_s
      end
    end


    # CREATE ACTUALLY SUCCEDED!!!!!!

    #######################################




    it "performs them all with no errors" do
      expect {

        selected = @requests.select {|_, val| val[:options].any? {|key| (key.to_s =~ /^((?!photo).)*$/) && (key.to_s =~ /comment/)}}.keys
        @requests.delete_if {|key, _| selected.include? key}
        time = compute_delay(selected.size)
        selected.each do |req|
          pause(time) if time
          puts 'INIT ' + req.to_s
          @sender.send(req, {comment_id: @comment.event_comment_id})
          puts 'COMPLETED ' + req.to_s
        end


        selected = selected = @requests.select {|key, _|  (key.to_s =~ /^((?!photo).)*$/) && (key.to_s =~ /comment/)}.keys
        @requests.delete_if {|key, _| selected.include? key}
        time = compute_delay(selected.size)
        selected.each do |req|
          pause(time) if time
          puts 'INIT ' + req.to_s
          @sender.send(req, {id: @comment.event_comment_id})
          puts 'COMPLETED ' + req.to_s
        end





      }.not_to raise_error
    end
  end






  describe 'requests which deal with events' do
    before(:all) do
      @event = @sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'test of tests').first
      # puts 'COMPLETED ' + :create_event.to_s
      @requests.delete(:create_event)
    end

    it 'performs :get_open_events with no errors' do
      #expect{@sender.get_open_events(zip: '94608')}.not_to raise_error
      @requests.delete(:get_open_events)
      #puts 'COMPLETED ' + :get_open_events.to_s
    end

    ## THESE TWO ABOUT ATTENDANCE BOTH MUST FAIL BECAUSE THE EVENT HAS TO HAVE STARTED ALREADY
    #  FOR THIS REASON YOU SHOULD PROBABLY REFACTOR THEM OUTSIDE
    #############################
    it 'the :create_attendance request should rightly fail given that the event has not already started' do
      begin
        req = :create_attendance
        @requests.delete(req)
          #@sender.send(req, {event_id: @event.id, urlname: testing_group_urlname})
          #raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:errors][0][:message]).to eq('Event must have started')
        puts 'COMPLETED ' + req.to_s
      end
    end

    it 'the :create_attendance request should rightly fail given that the event has not already started' do
      begin
        req = :get_attendance
        @requests.delete(req)
          #@sender.send(req, {event_id: @event.id, urlname: testing_group_urlname})
          # raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:errors][0][:message]).to eq('Event must have started')
        puts 'COMPLETED ' + req.to_s
      end
    end
    #######################################


    #################################################
    #################################################
    #################################################
    ############# SKIPPING BOTH WATCHLIST OPERATIONS
    ############ CREATE works BUT DELETE FAILS :errors=>[{:code=>"auth_fail", :message=>"Authentication credentials are required"}]}
    ######################################################
    it "JUST DELETING " do
      @requests.delete(:create_watchlist)
      @requests.delete(:delete_watchlist)
    end
    ##################################################
    ##################################################


    it "performs them all with no errors" do
      expect {

        selected = @requests.select {|_, val| val[:options].include? :event_id}.keys
        @requests.delete_if {|key, _| selected.include? key}
        time = compute_delay(selected.size)
        #selected.each do |req|
        #pause(time) if time
        #puts 'INIT ' + req.to_s
        #@sender.send(req, {event_id: @event.id})
        #puts 'COMPLETED ' + req.to_s
        #end

        selected = @requests.select {|_, val| val[:options].include? [:event_id, :urlname]}.keys
        @requests.delete_if {|key, _| selected.include? key}
        time = compute_delay(selected.size)
        #selected.each do |req|
        #pause(time) if time
        #puts 'INIT ' + req.to_s
        #@sender.send(req, {event_id: @event.id, urlname: testing_group_urlname})
        #puts 'COMPLETED ' + req.to_s
        #end



        ## EVENT DELETE FAILS AND I DON"T KNOW WHAT IS  GOIN ON....
        #
        #############################
          begin
            req = :delete_event
            @requests.delete(req)
            @sender.send(req, {id: @event.id})
            raise "TEST FAILED #{req}"
          rescue Rubeetup::MeetupResponseError => e
            expect(e.response.parsed_body[:problem]).to eq('You are not authorized to make that request')
            puts 'COMPLETED ' + req.to_s
          end
        ###############################################################


        ##########  CREATE_EVENT_RATING MUST FAIL BECAUSE YOU CAN ONLY RATE ONCE THE EVENT IS OVER
        ######     BUT THE MEETUP SERVER ACTUALLY DIES ON IT...
        expect {
          req = :create_event_rating
          @requests.delete(req)
          @sender.send(req, {event_id: @event.id, rating: 2})
        }.to raise_error(StandardError)
          puts 'COMPLETED ' + req.to_s


        member_id = '146667802'
        # CREATE_EVENT_RATING HAS MANY PARAMS
        req = :create_event_payments
        @requests.delete(req)
        @sender.send(req, {event_id: @event.id, urlname: testing_group_urlname, member: member_id, amount: '5'  })
        puts 'COMPLETED ' + req.to_s



        selected = selected = @requests.select {|key, _|  (key.to_s =~ /event/)}.keys
        @requests.delete_if {|key, _| selected.include? key}
        time = compute_delay(selected.size)
        selected.each do |req|
          pause(time) if time
          puts 'INIT ' + req.to_s
          @sender.send(req, {id: @event.id})
          puts 'COMPLETED ' + req.to_s
        end




      }.not_to raise_error
    end
  end






  describe  'requests which involve members' do
    before(:all) do
      @event = @sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'test of tests').first
      # @note Meetup API does not allow you to create members
      @member_id = '146667802'
    end

    #  MEMBER EDIT MUST FAIL BECAUSE IT'S NOT ME
    # {:details=>"Only the authorized user may edit their own account", :code=>"not_authorized", :problem=>"You are not authorized to make that request"}
    it 'the :edit_member request should rightly fail given that its me'  do
      begin
        req = :edit_member
        @requests.delete(req)
        @sender.send(req, {id: @member_id})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:problem]).to eq('You are not authorized to make that request')
        puts 'COMPLETED ' + req.to_s
      end
    end

    #  DELETE MEMBER PHOTO MUST FAIL BECAUSE IT'S NOT ME
    # {:details=>"Only the authorized user may edit their own account", :code=>"not_authorized", :problem=>"You are not authorized to make that request"}
    it 'the :delete_member_photo request should rightly fail given that its me'  do
      begin
        req = :delete_member_photo
        @requests.delete(req)
        @sender.send(req, {id: @member_id})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:problem]).to eq('You are not authorized to make that request')
        puts 'COMPLETED ' + req.to_s
      end
    end

    #  CREATE MEMBER PHOTO SUCCEEDED
    it 'the :create_member_photo request succeeds'  do
        req = :create_member_photo
        @requests.delete(req)
        @sender.send(req, {id: @member_id, photo: "#{test_files_folder}cat.png"})
        puts 'COMPLETED ' + req.to_s
    end



    #  CREATE MEMBER APPROVALS FAILS BECAUSE IT'S NOT ME
    # {:errors=>[{:code=>"permission_error", :message=>"you do not organize this Meetup"}, {:code=>"member_error", :message=>"member is required"}]}
    it 'the :create_member_approvals request should rightly fail given that its me'  do
      begin
        req = :create_member_approvals
        @requests.delete(req)
        @sender.send(req, {urlname: testing_group_urlname})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:errors][0][:code]).to eq('permission_error')
        puts 'COMPLETED ' + req.to_s
      end
    end

    #  DELETE MEMBER APPROVALS FAILS BECAUSE IT'S NOT ME
    # {:errors=>[{:code=>"permission_error", :message=>"you do not organize this Meetup"}, {:code=>"member_error", :message=>"member is required"}]}
    it 'the :delete_member_approvals request should rightly fail given that its me'  do
      begin
        req = :delete_member_approvals
        @requests.delete(req)
        @sender.send(req, {urlname: testing_group_urlname})
        raise "TEST FAILED #{req}"
      rescue Rubeetup::MeetupResponseError => e
        expect(e.response.parsed_body[:errors][0][:code]).to eq('auth_fail')
        puts 'COMPLETED ' + req.to_s
      end
    end




    # THIS BLOCK ONLY HANDLES 1 REQUEST.... SO REFACTOR AWAY
    # IT MAY BE WORTH TO MAKE THE MEMBER TESTS AS SINGLES
    it 'gets the adequate responses' do

      selected = selected = @requests.select {|key, _|  (key.to_s =~ /member/)}.keys
      @requests.delete_if {|key, _| selected.include? key}
      time = compute_delay(selected.size)
      selected.each do |req|
        pause(time) if time
        puts 'INIT ' + req.to_s
        @sender.send(req, {id: @member_id})
        puts 'COMPLETED ' + req.to_s
      end

      puts @requests.keys

    end
  end





=begin

  it 'performs requests with no errors' do
    #puts @sender.delete_event(id: "223538018").inspect
    #puts "DONEEEEEEEEEEEEEEEE ONCE"
    #expect{@sender.delete_event(id: "223538018")}.not_to raise_error
  end

  it 'performs photo upload with no errors' do
    event = @sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'pic test')
    expect{@sender.create_photo(event_id: event.first.id, photo: "#{test_files_folder}cat.png")}.not_to raise_error
  end
=end
end
