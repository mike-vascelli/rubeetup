require 'spec_helper'

describe Rubeetup::RequestBuilder do
  let(:builder) { Rubeetup::RequestBuilder }

  describe '#compose_request' do
    it 'creates a request instance' do
      request_type = builder.send(:request_type)
      expect(request_type).to receive(:new)
      builder.compose_request(:get_events, [])
    end

    context 'with invalid input verb' do
      it 'raises a RequestError' do
        expect{ builder.compose_request(:find_events, []) }
            .to raise_error(Rubeetup::RequestError)
      end
    end

    context 'with invalid input name (missing underscore)' do
      it 'raises a RequestError' do
        expect{ builder.compose_request(:getevents, []) }
            .to raise_error(Rubeetup::RequestError)
      end
    end
  end

end