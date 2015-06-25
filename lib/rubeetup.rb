require 'rubeetup/version'
require 'rubeetup/requester'
require 'rubeetup/errors'
require 'rubeetup/request_builder'
require 'rubeetup/request'
require 'rubeetup/request_sender'
require 'rubeetup/request_response'

module Rubeetup

  def self.setup(args)
    agent.new(get_auth_data(args))
  end

  # Include this call in a new file: config/initializers/rubeetup.rb
  # args must be a Hash including -->  api_key: 'val'
  def self.set_default_auth(args)
    @auth_options = args
  end


  private

  def self.agent
    @agent = Requester
  end

  # Trivial version
  # TO DO: Should be modified to allow for tokens as well
  def self.get_auth_data(args)
    args || @auth_options
  end

end
