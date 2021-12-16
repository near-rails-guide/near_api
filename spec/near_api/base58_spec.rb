# frozen_string_literal: true
require 'spec_helper'

RSpec.describe NearApi::Base58 do
  describe '.encode' do
    it 'encodes bytestring to base58 string' do
      bytestring = '012345'
      encoded = described_class.encode(bytestring)
      expect(encoded).to eq('QzuGBrxU')
      expect(described_class.decode(encoded)).to eq(bytestring)
    end
  end

  describe '.decode' do
    it 'decodes base58 string to bytestring' do
      expect(described_class.decode('QzuGBrxU')).to eq('012345')
    end
  end
end
