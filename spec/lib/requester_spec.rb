require 'spec_helper'

describe Rubeetup::Requester do

  describe '#initialize' do
    context 'with valid auth data' do
      it 'does nothing' do
        expect{Rubeetup::Requester.new(key: '1234')}.not_to raise_error
      end
    end

    context 'with invalid auth data' do
      context '(non-Hash-behaving auth data)' do
        it 'raises InvalidAuthenticationError' do
          expect{Rubeetup::Requester.new('54545')}.to raise_error(Rubeetup::InvalidAuthenticationError)
        end
      end

      context '(Hash missing :key)' do
        it 'raises InvalidAuthenticationError' do
          expect{Rubeetup::Requester.new(keyyy: 'val')}.to raise_error(Rubeetup::InvalidAuthenticationError)
        end
      end
    end
  end

  describe 'handling requests' do
    let(:agent) {Rubeetup::Requester.new(key: 'val')}
    let(:request) {instance_double('Request', execute!: nil)}

    before(:each) do
      allow(agent.request_builder).to receive(:compose_request).and_return(request)
    end

    it 'delegates creation of requests' do
      expect(agent.request_builder).to receive(:compose_request)
      agent.get_events
    end

    it 'attempts to execute any user-sent request' do
      expect(request).to receive(:execute!)
      agent.get_events
    end
  end

end