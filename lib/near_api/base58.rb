# frozen_string_literal: true

class NearApi::Base58
  BASE = '123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz'

  def self.encode(bytestring)
    number = bytestring.unpack('C*').reverse.each_with_index.inject(0) do |sum, (byte, index)|
      sum + byte * (256**index)
    end
    nzeroes = bytestring.bytes.find_index { |b| b != 0 } || bytestring.length - 1
    prefix = BASE[0] * nzeroes
    prefix + tos(number)
  end

  def self.decode(encoded_string)
    integer = toi encoded_string
    nzeroes = encoded_string.chars.find_index { |c| c != BASE[0] } || encoded_string.length - 1
    prefix = nzeroes < 0 ? '' : 0.chr * nzeroes
    prefix + to_bytestring(integer)
  end

  def self.toi(string = to_s, base = 58, digits = BASE)
    return nil if string.empty?

    integer = 0
    string.each_char do |c|
      index = digits.index(c)
      integer = integer * base + index
    end
    integer
  end

  def self.tos(integer = to_i, base = 58, digits = BASE)
    return '' if integer.nil?
    return digits[0] if integer == 0

    string = ''
    while integer > 0
      integer, index = integer.divmod(base)
      string = digits[index] + string
    end
    string
  end

  def self.to_bytestring(number)
    return 0.chr if number == 0

    integer = number
    result = ''
    while integer > 0
      integer, remain = integer.divmod(256)
      result = remain.chr + result
    end
    result
  end
end
