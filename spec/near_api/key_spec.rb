# frozen_string_literal: true
require 'spec_helper'

RSpec.describe NearApi::Key do
  describe '#initialize' do
    subject(:key) { described_class.new('test.near', key_pair: key_pair, public_key: public_key) }
    let(:key_pair) { 'ed25519:2wyRcSwSuHtRVmkMCGjPwnzZmQLeXLzLLyED1NDMt4BjnKgQL6tF85yBx6Jr26D2dUNeC716RBoTxntVHsegogYw' }
    let(:public_key) { nil }

    it 'initialize without and error' do
      expect { key }.not_to raise_exception
    end

    context 'with public_key only' do
      let(:key_pair) { nil }
      let(:public_key) { 'ed25519:22skMptHjFWNyuEWY22ftn2AbLPSYpmYwGJRGwpNHbTV' }

      it 'initialize without and error' do
        expect { key }.not_to raise_exception
      end
    end

    context 'with keypair and matching public key' do
      let(:key_pair) { 'ed25519:2wyRcSwSuHtRVmkMCGjPwnzZmQLeXLzLLyED1NDMt4BjnKgQL6tF85yBx6Jr26D2dUNeC716RBoTxntVHsegogYw' }
      let(:public_key) { 'ed25519:22skMptHjFWNyuEWY22ftn2AbLPSYpmYwGJRGwpNHbTV' }

      it 'initialize without and error' do
        expect { key }.not_to raise_exception
      end
    end

    context 'when keypair and public_key are missing' do
      let(:key_pair) { nil }
      let(:public_key) { nil }

      it 'raises an error' do
        expect { key }.to raise_exception ArgumentError, 'please specify key_pair or public_key'
      end
    end

    context 'when public_key does not match keypair' do
      let(:key_pair) { 'ed25519:2wyRcSwSuHtRVmkMCGjPwnzZmQLeXLzLLyED1NDMt4BjnKgQL6tF85yBx6Jr26D2dUNeC716RBoTxntVHsegogYw' }
      let(:public_key) { 'ed25519:BEU6Smwd5nADfTknr4r5E751Me6L4fNL7obQHYbh4FCL' }

      it 'raises an error' do
        expect { key }.to raise_exception ArgumentError, 'public_key does not match keypair'
      end
    end
  end
end

