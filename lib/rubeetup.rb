require 'rubeetup/version'
require 'rubeetup/requester'
require 'rubeetup/errors'

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

  def self.set_default_auth(args)
    @auth_options = args
  end

end
