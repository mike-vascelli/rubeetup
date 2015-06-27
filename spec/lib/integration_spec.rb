require 'spec_helper'

describe 'Rubeetup' do
  before(:all) do
    @sender = Rubeetup.setup(key: api_key)
  end

  it 'performs requests with no errors' do
    #puts @sender.get_events(group_urlname: 'Meetup-API-Testing').is_a? Array
    expect{@sender.get_events(group_urlname: 'Meetup-API-Testing')}.not_to raise_error
  end


  it 'performs requests with no errors' do
    #puts @sender.get_open_events(zip: '94608').inspect
    expect{@sender.get_open_events(zip: '94608')}.not_to raise_error
  end

  it 'performs requests with no errors' do
    #puts @sender.get_concierge(zip: '94608').inspect
    expect{@sender.get_concierge(zip: '94608')}.not_to raise_error
  end

  # CRUD
  it 'performs requests with no errors' do
    #puts @sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'peppe test').inspect
    expect{@sender.create_event(group_id: testing_group_id, group_urlname: testing_group_urlname, name: 'peppe test')}.not_to raise_error
  end

  it 'performs requests with no errors' do
    #puts @sender.get_event(id: "223538018").inspect
    #expect{@sender.get_event(id: "223538018")}.not_to raise_error
  end

  it 'performs requests with no errors' do
    #puts @sender.edit_event(id: "223538018").inspect
    #expect{@sender.edit_event(id: "223538018")}.not_to raise_error
  end

  it 'performs requests with no errors' do
    #puts @sender.delete_event(id: "223538018").inspect
    #puts "DONEEEEEEEEEEEEEEEE ONCE"
    #expect{@sender.delete_event(id: "223538018")}.not_to raise_error
  end
end