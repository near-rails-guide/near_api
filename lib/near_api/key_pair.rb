# frozen_string_literal: true
require 'ed25519'

class NearApi::KeyPair
  def initialize(value)
    key_value = if value.include?(':')
                  value.split(':').last
                else
                  value
                end
    bytestring = NearApi::Base58.decode(key_value)
    @key_pair = Ed25519::SigningKey.from_keypair(bytestring)
  end

  def public_key
    key_pair.verify_key.to_bytes
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
