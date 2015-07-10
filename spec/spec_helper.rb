require 'coveralls'
Coveralls.wear!

require 'rubeetup'
require 'vcr'
require 'zlib'

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
# Determines whether the integration test suite should be run all the way to
# the Meetup server or not
#
def local_testing
  ENV['LIVE_TEST'] != 'true'
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
# The discussion board id to the Meetup API Testing Sandbox
#
def testing_board_id
  '1195382'
end

##
# The member id of a random member of the Meetup API Testing Sandbox
# @note The Meetup API does not allow you to create member ids so here we are...
#
def testing_member_id
  '184911456'
end

##
# The topic id of a random topic
# @note The Meetup API does not allow you to create topics so here we are...
#
def testing_topic_id
  '197471'
end

##
# Implements the storage interface used by VCR. It delegates to a Zipper instance
# the job of compressing and decompressing canned data.
#
class CassettePersister
  def initialize(system)
    @system = system
  end

  def [](name)
    @system.get(absolute_path_to_file(name))
  end

  def []=(name, content)
    @system.set(absolute_path_to_file(name), content)
  end

  def absolute_path_to_file(name)
    file = "test_files/cassettes/#{name}.gz"
    File.expand_path(file, File.dirname(__FILE__))
  end
end

##
# Implements a file compressor and decompressor which we will use to compress
# the canned data files coming from VCR.
# It is amazing really. Before the folder was 9MB, now it is 2.3MB, and the
# processing cost is negligible, especially for the reads.
#
class Zipper
  def get(name)
    begin
      Zlib::GzipReader.open(name) {|gzip| gzip.read}
    rescue
      # Missing file so tests must go to the server
    end
  end

  def set(name, content)
    File.open(name, 'w') do |file|
      gzip = Zlib::GzipWriter.new(file)
      gzip << content
      gzip.close
    end
  end
end

VCR.configure do |c|
  c.cassette_persisters[:persister] = CassettePersister.new(Zipper.new)
  c.allow_http_connections_when_no_cassette = true
  c.hook_into :webmock
  c.cassette_library_dir = 'spec/test_files/cassettes'
  c.default_cassette_options = {persist_with: :persister,
                                match_requests_on: [:method,
                                                    VCR.request_matchers.uri_without_param(:key)]}
end
