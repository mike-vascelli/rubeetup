require 'spec_helper'

describe 'Rubeetup' do
  before(:all) do
    @sender = Rubeetup.setup(key: api_key)
  end

  it 'performs requests with no errors' do
    puts @sender.get_events(group_urlname: 'Meetup-API-Testing').is_a? Array
    expect{@sender.get_events(group_urlname: 'Meetup-API-Testing')}.not_to raise_error
  end
end