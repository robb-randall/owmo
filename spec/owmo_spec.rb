# frozen_string_literal: true

require 'spec_helper'

RSpec.describe OWMO do
  it 'has a version number' do
    expect(OWMO::VERSION).not_to be_nil
  end

  describe '#weather' do
    let(:api_key) { '12345678901234567890123456789012' }

    it 'returns Weather object' do
      expect(described_class.weather(api_key).is_a?(OWMO::Weather)).to be(true)
    end

    it 'yields Weather object' do
      expect(described_class.weather(api_key) { |weather| weather }.is_a?(OWMO::Weather)).to be(true)
    end
  end
end
