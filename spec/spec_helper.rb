require 'coveralls'
Coveralls.wear!

require 'rubeetup'

def api_key
  ENV['MEETUP_KEY']
end

def testing_group_id
  1556336
end

def testing_group_urlname
  'Meetup-API-Testing'
end