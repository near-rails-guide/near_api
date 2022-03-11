# frozen_string_literal: true

require 'ed25519'

class NearApi::Key
  attr_reader :signer_id, :public_key

  def initialize(signer_id = ENV.fetch('NEAR_SIGNER_ID'),
                 key_pair: ENV.fetch('NEAR_KEYPAIR', nil),
                 public_key: ENV.fetch('NEAR_PUBLIC_KEY', nil))
    @signer_id = signer_id
    if (!key_pair.nil? && !public_key.nil?) || (key_pair.nil? && public_key.nil?)
      raise ArgumentError, 'please specify one of: key_pair or public_key'
    end

    unless key_pair.nil?
      key_value = if key_pair.include?(':')
                    key_pair.split(':').last
                  else
                    key_pair
                  end
      bytestring = NearApi::Base58.decode(key_value)
      @key_pair = Ed25519::SigningKey.from_keypair(bytestring)
      @public_key = @key_pair.verify_key.to_bytes
    end

    unless public_key.nil?
      key_value = if public_key.include?(':')
                    public_key.split(':').last
                  else
                    public_key
                  end
      bytestring = NearApi::Base58.decode(key_value)
      @public_key = Ed25519::VerifyKey.new(bytestring).to_bytes
    end
  end

  def key_type
    0
  end

  def sign(msg)
    key_pair.sign(msg)
  end

  private

  attr_reader :key_pair
end
