require 'spec_helper'

describe Rubeetup do

  describe '.setup' do
    it 'creates a Requester' do
      #allow(Rubeetup).to receive(:get_auth_data).and_return(double)
      expect(Rubeetup.setup({api_key: '123'})).to be_an_instance_of(Rubeetup::Requester)
    end
  end

  # Simple version
  # This method should eventually be modified to allow for tokens as well
  describe '#get_auth_data' do
    context 'with default auth data' do
      it 'returns the default authentication data received by the user' do
        default_args = {api_key: '12345'}
        Rubeetup.set_default_auth(default_args)
        expect(Rubeetup.get_auth_data(default_args)).to eq(default_args)
      end
    end

    context 'with new auth data' do
      it 'returns the new authentication data received by the user' do
        args = {api_key: '12345'}
        expect(Rubeetup.get_auth_data(args)).to eq(args)
      end
    end

    context 'with default and new auth data' do
      it 'returns the new authentication data received by the user' do
        default_args = {api_key: '12345'}
        args = {api_key: '12345'}
        Rubeetup.set_default_auth(default_args)
        expect(Rubeetup.get_auth_data(args)).to eq(args)
      end
    end
  end

end