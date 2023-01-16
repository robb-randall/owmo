# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OWMO do
  it 'has a version number' do
    expect(OWMO::VERSION).not_to be nil
  end

  describe '#weather' do
    let(:api_key) { '12345678901234567890123456789012' }

    it 'returns Weather object' do
      described_class.weather(api_key).is_a? OWMO::Weather
    end

    it 'yields Weather object' do
      described_class.weather(api_key) { |weather| weather.is_a? OWMO::Weather }
    end
  end
end
