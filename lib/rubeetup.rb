require 'rubeetup/version'
require 'rubeetup/requester'
require 'rubeetup/errors'
require 'rubeetup/request_builder'

module Rubeetup

  def self.setup(args = {})
    auth_options = get_auth_data(args)
    Requester.new(auth_options)
  end

  # Trivial version
  # Should be modified to allow for tokens as well
  def self.get_auth_data(args = {})
    #puts "DEFAULT AUTH DATA => #{@auth_options}"
    args || @auth_options
  end

  # Include this call in a new file: config/initializers/rubeetup.rb
  # args must be a Hash including -->  api_key: 'val'
  def self.set_default_auth(args)
    @auth_options = args
  end

end
