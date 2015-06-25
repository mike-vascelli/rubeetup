require 'spec_helper'

describe Rubeetup::RequestBuilder do
  let(:builder) {Rubeetup::RequestBuilder.new}

  describe '#compose_request' do
    it 'creates a request instance' do
      expect(builder.request).to receive(:new)
      builder.compose_request(:get_events, [])
    end
  end

end