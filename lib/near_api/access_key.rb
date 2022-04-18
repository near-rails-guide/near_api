# frozen_string_literal: true

class NearApi::AccessKey
  include Borsh

  borsh nonce: :u64,
        permission: :borsh

  def initialize(permission)
    @permission = permission
  end

  private

  attr_reader :permission

  def nonce
    0
  end
end
