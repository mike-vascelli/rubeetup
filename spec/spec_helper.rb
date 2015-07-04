require 'coveralls'
Coveralls.wear!

require 'rubeetup'
require 'vcr'
require 'time'

##
# Determines whether integration testing is local only, or live over the net
#
def local_testing
  false
end

##
# Gives you the location of the test files
# @return [String] Directory containing all test files
#
def test_files_folder
  'spec/test_files/'
end

def api_key
  ENV['MEETUP_KEY'] || testing_apikey
end

def testing_apikey
  # Set your key if you want.
  # Alternatively you could create an environment variable 'MEETUP_KEY'
  # and let this method as is.
end

##
# @note If you want to perform live testing of the API, then you have to join
# the Meetup API Testing Sandbox.
# It is a completely free procedure, but it may take a few days depending on
# the speed with which the Meetup people will reply back to your join request.
# Once they get back to you, your Meetup API key will have administrative
# privileges for the 'Meetup-API-Testing' group, which means that you will be
# able to perform all the requests available through the API when they involve
# this particular Testing group.

##
# This group_id belongs to the Meetup API Testing Sandbox
#
def testing_group_id
  1556336
end

##
# This group_urlname belongs to the Meetup API Testing Sandbox
#
def testing_group_urlname
  'Meetup-API-Testing'
end

##
# This sets the interval of time that should pass before VCR re-records all the
# test files
#
def recording_interval
  (DateTime.now + 7).to_time - DateTime.now.to_time
end

VCR.configure do |c|
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/test_files/cassettes'
  c.default_cassette_options = {:re_record_interval => recording_interval}
end
