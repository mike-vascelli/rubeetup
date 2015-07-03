require 'rubeetup/version'
require 'rubeetup/utilities'
require 'rubeetup/requests_catalog'
require 'rubeetup/requester'
require 'rubeetup/errors'
require 'rubeetup/request_builder'
require 'rubeetup/request'
require 'rubeetup/request_sender'
require 'rubeetup/request_response'
require 'rubeetup/response_wrapper'


require 'byebug'




##
# @author Mike Vascelli <michele.vascelli@gmail.com>
#
# This module simplifies interaction with the Meetup.com API.
# It gives you easy access to all of the available API methods, and it checks
# that all the required parameters are provided with each request.
# For more information on the Meetup API itself, visit: http://www.meetup.com/meetup_api/
#
# ==Requests' Naming Convention
# They begin with the action to perform on a resource: (i.e. create, get, edit, delete)
# and are followed by underscore, and then the name of the resource requested
# (as in the Meetup API).
# ===Eg.
# http://www.meetup.com/meetup_api/docs/2/open_events/
#
# resource::     open_events
# action::       get
#
# request name:: get_open_events
#
# Check out the names of the supported requests, and their respective
# required arguments in +rubeetup/requests_lib/meetup_catalog.rb+, in the
# MeetupCatalog documentation, or at: http://www.meetup.com/meetup_api/
#
# ==Authorization
# Rubeetup will need a Meetup api key to successfully perform the requests.
# This can be obtained by signing-up at http://www.meetup.com, and by requesting
# a key for your account.
#
#
# Note that in order to +edit+, +create+, or +delete+ any resource in the API,
# you must first obtain the privileges to do those actions. This usually means
# becoming an organizer for a group. This can be achieved by either starting
# a meetup group, or by being granted the authorization by a current organizer
# of a group.
# If you want to experiment with the API or simply do some live testing, then you can
# request to become an organizer for the <tt>Meetup API Testing Sandbox Group</tt>.
# Visit here http://www.meetup.com/Meetup-API-Testing for more information.
#
# ==Usage
#   auth = key: 'val'
#
#   # If you wish to provide auth data for each instance,
#   # then pass it to the Rubeetup.setup call as an argument:
#   #
#   requester = Rubeetup.setup(auth)
#
#   # Otherwise you can pass default auth data once and be done with it:
#   #
#   Rubeetup.default_auth(auth)
#   requester = Rubeetup.setup
#
#
#   # Each request will take a Hash of options.
#   # Check in rubeetup/requests_lib/meetup_catalog.rb, or in the
#   # MeetupCatalog documentation, or at: http://www.meetup.com/meetup_api
#   # for a list of required and available parameters for your specific request.
#   #
#   # Rubeetup will raise an Error if any request is attempted without
#   # providing all the required parameters.
#   #
#   events = requester.get_events(group_urlname: 'Meetup-API-Testing')
#
#
#   # Every request returns an array of results, and you can safely iterate over them.
#   # Furthermore, each result stored in the array is a symbol-keyed Hash.
#   #
#   events.each do |event|
#     # Each element is a Hash, so you can simply do:
#     puts event[:name]
#
#     # But Rubeetup also allows you to access elements' keys in OO-style:
#     puts event.name
#           .
#           .
#           .
#     puts event.time
#     puts event.duration
#
#     venue = event.venue
#     puts venue[:address_1]
#     puts venue[:city]
#   end
#
#
# To find out about all the available response attributes visit the Meetup API documentation:
# http://www.meetup.com/meetup_api
#
# For example, for the +events+ API request in the +Usage+ example above, check this link:
# http://www.meetup.com/meetup_api/docs/2/events
#
module Rubeetup
  # Entry point to the Rubeetup client.
  # It creates an object which handles all the requests for you.
  # @param args [Hash{Symbol=>String}, nil] holds auth data to send with each request
  # @option args [String] :key the api key
  # @return [Rubeetup::Requester] the object which makes requests for the API user
  #
  def self.setup(args = nil)
    agent.new(get_auth_data(args))
  end

  ##
  # Sets up permanent default auth data.
  # If on Rails, you could include this call in a new file: config/initializers/rubeetup.rb
  # @param [Hash{Symbol=>String}] args holds auth data to send with each request
  # @option args [String] :key the api key
  # @return [nil]
  #
  def self.default_auth(args)
    @auth_options = args
    nil
  end

  class << self
    private

    def agent
      @agent = Requester
    end

    # Trivial version
    # @todo Should be modified to allow for tokens as well
    #
    def get_auth_data(args)
      args || @auth_options
    end
  end
end
