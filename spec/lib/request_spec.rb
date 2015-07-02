require 'spec_helper'

describe Rubeetup::Request do
  let(:klass) { Rubeetup::Request }

  def stub_mix_ins
    allow_any_instance_of(klass).to receive(:request_path).and_return(lambda {|_|})
    allow_any_instance_of(klass).to receive(:request_multipart).and_return(nil)
  end

  describe '#execute' do
    it 'delegates its own execution to a dependency injected into #sender' do
      allow_any_instance_of(klass).to receive(:validate_request)
      stub_mix_ins

      request = klass.new
      expect(request.sender).to receive(:get_response)
      request.execute
    end
  end

  context 'validates itself during initialization' do
    it 'raises RequestError for non-existent request names' do
      allow_any_instance_of(klass).to receive(:validate_options)
      allow_any_instance_of(klass).to receive(:find_in_catalog).and_return(false)
      stub_mix_ins

      expect{ klass.new(name: :get_madness) }.to raise_error(Rubeetup::RequestError)
    end

    it 'raises RequestError for missing a required option' do
      allow_any_instance_of(klass).to receive(:verify_existence)
      allow_any_instance_of(klass).to receive(:required_options).and_return([:id])
      stub_mix_ins

      expect{ klass.new(options: {}) }.to raise_error(Rubeetup::RequestError)
    end
  end
end