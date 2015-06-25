require 'json'

module Rubeetup
  class RequestResponse

    def initialize(raw_data)
      # CHECK HEADER FIRST AND IN CASE THROW EXCEPTION

      JSON.parse(raw_data, symbolyze_names: true)
    end
=begin
    def method_missing(name, *args)

    end
=end
 end
end