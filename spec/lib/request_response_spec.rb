require 'spec_helper'

describe Rubeetup::RequestResponse do
  describe '#data' do
    before(:each) do

    end

    context 'for an unsuccessful response' do
      it 'raises a MeetupResponseError' do
        data = double(body: '')
        allow(data).to receive(:is_a?).with(Net::HTTPSuccess).and_return(false)
        allow(JSON).to receive(:parse).and_return({})
        response = Rubeetup::RequestResponse.new(data)
        expect{ response.data }.to raise_error(Rubeetup::MeetupResponseError)
      end
    end

    context 'for a successful response' do
      def test_body(payload)
        data = double(body: '')
        allow(data).to receive(:is_a?).with(Net::HTTPSuccess).and_return(true)
        allow(JSON).to receive(:parse).and_return(payload)
        response = Rubeetup::RequestResponse.new(data)
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
