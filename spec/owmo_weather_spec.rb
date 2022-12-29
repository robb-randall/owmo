# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OWMO::Weather do
  describe '#initialize' do
    let(:api_key) { '12345678901234567890123456789012' }

    it 'returns Weather object' do
      OWMO::Weather.new(api_key).is_a? OWMO::Weather
    end
    it 'yields Weather object' do
      OWMO::Weather.new(api_key) { |weather| weather.is_a? OWMO::Weather }
    end
  end
end
