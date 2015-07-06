require 'spec_helper'

describe Rubeetup::RequestSender do
  describe '#get_response' do
    it 'delegates the job to a dependency injected into #response_wrapper' do
      sender = Rubeetup::RequestSender.new
      dependency = sender.send :response_class
      dependency_instance = double
      allow(dependency).to receive(:new).and_return(dependency_instance)
      allow(sender).to receive(:fetch)
      expect(dependency_instance).to receive(:data)
      sender.get_response(double)
    end
  end
end
