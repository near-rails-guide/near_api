# frozen_string_literal: true
require 'spec_helper'

RSpec.describe NearApi::Api do
  let(:api) { described_class.new(config) }
  let(:config) do
    NearApi::Config.new(node_url: 'https://rpc.ci-testnet.near.org')
  end
  let(:key) { NearApi::Key.new(
    'test.near',
    key_pair: 'ed25519:2wyRcSwSuHtRVmkMCGjPwnzZmQLeXLzLLyED1NDMt4BjnKgQL6tF85yBx6Jr26D2dUNeC716RBoTxntVHsegogYw'
  )}

  describe '#view_access_key' do
    subject(:response) { api.view_access_key(key) }

    it 'retuns a valid response' do
      expect(response).to be_a(Hash)
      expect(response['result'].keys).to include('nonce', 'permission', 'block_height', 'block_hash')
    end
  end

  describe '#status' do
    subject(:response) { api.status }

    it 'returns status' do
      expect(response).to be_a(Hash)
      expect(response['sync_info'].keys).to include('latest_block_hash', 'latest_block_height', 'latest_state_root')
    end
  end
end
