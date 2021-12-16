# frozen_string_literal: true

class NearApi::Config
  def initialize(
    signer_id: ENV.fetch('NEAR_SIGNER_ID'),
    key_pair: ENV.fetch('NEAR_KEYPAIR'),
    node_url: ENV.fetch('NEAR_NODE_URL')
  )
    @signer_id = signer_id
    @key_pair = NearApi::KeyPair.new(key_pair)
    @node_url = node_url
  end

  attr_reader :signer_id, :key_pair, :node_url
end
