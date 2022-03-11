# frozen_string_literal: true

class NearApi::Yocto
  def self.from_near(amount)
    amount * 10**24
  end

  def self.to_near(amount)
    amount.to_f / 10**24
  end
end
