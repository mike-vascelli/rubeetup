require 'spec_helper'

def klass
  Rubeetup::Requester
end

describe Rubeetup do

  describe '.setup' do
    let(:default_args) {{key: '12345'}}
    let(:args) {{key: '343434343'}}

    before(:each) do
      Rubeetup.default_auth(nil)
    end

    it 'creates a Requester' do
      expect(Rubeetup.setup(args)).to be_an_instance_of(klass)
    end

    context 'with only default auth data' do
      it 'uses the default authentication data received by the user' do
        Rubeetup.default_auth(default_args)
        expect(klass).to receive(:new).with(default_args)
        Rubeetup.setup
      end
    end

    context 'with only new auth data' do
      it 'uses the new authentication data received by the user' do
        expect(klass).to receive(:new).with(args)
        Rubeetup.setup(args)
      end
    end

    context 'with default and new auth data' do
      it 'uses the new authentication data received by the user' do
        Rubeetup.default_auth(default_args)
        expect(klass).to receive(:new).with(args)
        Rubeetup.setup(args)
      end
    end
  end
end