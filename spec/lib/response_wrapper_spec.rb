require 'spec_helper'

describe Rubeetup::ResponseWrapper do
  describe '#method_missing' do
    before(:all) do
      @val = 'Alfred'
      @key = :name
      response = {@key => @val}
      @wrapper = Rubeetup::ResponseWrapper.new(response)
    end

    context 'for a valid request' do
      it 'responds to Hash access operations' do
        expect(@wrapper[@key]).to eq(@val)
      end

      it 'responds to Object-Oriented-like operations' do
        expect(@wrapper.send(@key)).to eq(@val)
      end
    end

    context 'for an invalid request' do
      let(:wrong_key) {:time}
      it 'fails to respond to Hash access operations' do
        expect{@wrapper[wrong_key]}.to raise_error(NoMethodError)
      end

      it 'fails to respond to Object-Oriented-like operations' do
        expect{@wrapper.send(wrong_key)}.to raise_error(NoMethodError)
      end
    end
  end
end