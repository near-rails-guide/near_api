# frozen_string_literal: true

class NearApi::Action
  include Borsh

  borsh signer_id: :string,
        key_pair: { key_type: :u8, public_key: 32 },
        nonce: :u64,
        receiver_id: :string,
        block_hash: 32,
        actions: [:borsh]

  def self.call(*args)
    new(*args).call
  end

  def self.async(*args)
    new(*args).async
  end

  def initialize(receiver_id, actions, config: NearApi.config)
    @receiver_id = receiver_id
    @actions = Array[actions]
    @config = config
    @api = NearApi::Api.new(config)
  end

  def call
    call_api('broadcast_tx_commit')
  end

  def async
    call_api('broadcast_tx_commit')
  end

  private


  def call_api(method)
    msg = to_borsh
    digest = Digest::SHA256.digest(msg)
    signature = key_pair.sign(digest)

    signed_transaction = msg + Borsh::Integer.new(key_pair.key_type, :u8).to_borsh + signature
    api.json_rpc(method, [Base64.strict_encode64(signed_transaction)])
  end

  def signer_id
    config.signer_id
  end

  def key_pair
    config.key_pair
  end

  def nonce
    api.nonce + 1
  end

  def block_hash
    api.block_hash
  end

  attr_reader :receiver_id, :actions, :config, :api
end
