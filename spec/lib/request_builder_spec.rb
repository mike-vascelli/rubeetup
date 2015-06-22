require 'spec_helper'

describe Rubeetup::RequestBuilder do
  let(:builder) {Rubeetup::RequestBuilder.new}

  describe '#compose_request' do
    it 'creates a request instance' do
      expect(builder.request).to receive(:new)
      builder.compose_request(:get_events, [])
    end
  end


  ###############################################################
  ###############################################################
  #########   PRIVATE METHODS  ##################################
  ###############################################################

  describe '#split' do
    context 'with invalid input name(missing underscore)' do
      it 'returns [nil, nil]' do
        result = builder.split(:getevents)
        expect(result == [nil, nil]).to be true
      end
    end
  end

  describe '#determine_http_verb' do
    context 'with invalid input verb' do
      it 'it returns   :invalid' do
        result = builder.determine_http_verb(:put)
        expect(result == :invalid).to be true
      end
    end
  end
end