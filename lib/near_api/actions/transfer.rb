# frozen_string_literal: true

module NearApi
  module Actions
    class Transfer
      include Borsh

      borsh action_code: :u8,
            amount: :u128

      def initialize(near_amount: nil, amount: nil)
        if (near_amount.nil? && amount.nil?) || (!near_amount.nil? && !amount.nil?)
          raise ArgumentError, 'please specify one of: near_amount or amount'
        end

        @amount = amount unless amount.nil?
        @amount = Yocto.from_near(near_amount) unless near_amount.nil?
      end

      private

      attr_reader :amount

      def action_code
        3
      end
    end
  end
end
