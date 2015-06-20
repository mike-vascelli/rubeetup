require 'spec_helper'

describe 'Requester' do

  describe '#initialize' do
    context 'with valid auth data' do
      it 'does nothing' do
        expect{Rubeetup::Requester.new(api_key: '1234')}.not_to raise_error(Rubeetup::InvalidAuthenticationError)
      end
    end

    context 'with invalid auth data' do
      it 'raises InvalidAuthenticationError' do
        expect{Rubeetup::Requester.new('54545')}.to raise_error(Rubeetup::InvalidAuthenticationError)
      end
    end

  end


end