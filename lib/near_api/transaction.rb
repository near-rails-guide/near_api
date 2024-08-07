# frozen_string_literal: true

module NearApi
  class Transaction
    include Borsh

    borsh signer_id: :string,
          key: { key_type: :u8, public_key: 32 },
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

    def initialize(receiver_id, actions, config: NearApi.config, key: NearApi.key)
      @key = key
      @receiver_id = receiver_id
      @actions = Array(actions)
      @config = config
      @api = NearApi::Api.new(config)
    end

    def call(wait_until: Status::EXECUTED_OPTIMISTIC)
      signature = key.sign(message.digest)
      call_api(message.message, signature, wait_until: wait_until)
    end

    def message
      @message ||= begin
        message = to_borsh
        Struct.new(:message, :digest).new(message, Digest::SHA256.digest(message))
      end
    end

    def transaction_hash
      NearApi::Base58.encode(message.digest)
    end

    def call_api(message, signature, wait_until: Status::EXECUTED_OPTIMISTIC)
      signed_transaction = message + Borsh::Integer.new(key.key_type, :u8).to_borsh + signature
      params = { signed_tx_base64: Base64.strict_encode64(signed_transaction), wait_until: wait_until }
      api.json_rpc('send_tx', params)
    end

    private

    def signer_id
      key.signer_id
    end

    def nonce
      api.nonce(key) + 1
    end

    def block_hash
      api.block_hash
    end

    attr_reader :receiver_id, :actions, :key, :config, :api
  end
end
