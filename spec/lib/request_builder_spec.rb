require 'spec_helper'

describe Rubeetup::RequestBuilder do
  let(:builder) {Rubeetup::RequestBuilder.new}

  describe '#compose_request' do
    it 'creates a request instance' do
      expect(builder.request).to receive(:new)
      builder.compose_request(:get_events, [])
    end
  end

  #private method
  describe '#split' do
    context 'with invalid input name(missing underscore)' do
      it 'returns [nil, nil]' do
        result = builder.split(:getevents)
        expect(result == [nil, nil]).to be true
      end
    end
  end
end