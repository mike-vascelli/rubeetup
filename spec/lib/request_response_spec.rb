require 'spec_helper'

describe Rubeetup::RequestResponse do
  describe '#data' do
    before(:each) do
      @raw_data = double(body: '')
      @sender = double(response_data: @raw_data, request: double(to_s: ''))
    end

    context 'for an unsuccessful response' do
      it 'raises a MeetupResponseError' do
        parsed_body = double(:[] => {})
        allow(JSON).to receive(:parse).and_return(parsed_body)
        response = Rubeetup::RequestResponse.new(@sender)
        expect{ response.data }.to raise_error(Rubeetup::MeetupResponseError)
      end
    end

    context 'for a successful response' do
      def test_body(payload)
        allow(@raw_data).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
        allow(JSON).to receive(:parse).and_return(payload)
        response = Rubeetup::RequestResponse.new(@sender)
        expect(response.data).to be_an(Array)
      end

      context 'for a payload which responds to [:results]' do
        it 'returns an array of results' do
          test_body({results: ['something']})
        end
      end

      context 'for a payload which does not respond to [:results]' do
        it 'returns an array of results' do
          test_body({nope: 'peppe'})
        end
      end
    end
  end
end
