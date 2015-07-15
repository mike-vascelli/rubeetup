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
        expect{@wrapper[wrong_key]}.to raise_error(ArgumentError)
      end

      it 'fails to respond to Object-Oriented-like operations' do
        expect{@wrapper.send(wrong_key)}.to raise_error(NoMethodError)
      end
    end
  end

  describe '.wrapperize!' do
    def worker(input)
      return [] unless input.is_a? Rubeetup::ResponseWrapper
      [1] + input.values.map { |val|  worker(val) }
    end

    def wrapper_counter(data)
      worker(data).flatten.reduce(:+)
    end

    context 'a non-nested Hash' do
      it 'wraps the hash' do
        outer = {one: 1, two: 2, three: 3, four: 4, five: 5}
        result = Rubeetup::ResponseWrapper.wrapperize! outer
        expect(wrapper_counter result).to eq(1)
      end
    end

    context 'a nested Hash' do
      it 'wraps every nested Hash' do
        first_inner = {one: 1, two: 2, three: 3, four: 4, five: 5}
        second_inner = {one: first_inner, two: 2, three: 3, four: 4, five: 5}
        third_inner = {one: 1, two: second_inner, three: 3, four: 4, five: 5}
        outer = {one: 1, two: 2, three: third_inner, four: 4, five: 5}
        result = Rubeetup::ResponseWrapper.wrapperize! outer
        expect(wrapper_counter result).to eq(4)
      end
    end
  end
end