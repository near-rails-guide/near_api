# frozen_string_literal: true

module NearApi
  module Actions
    class FunctionCall
      include Borsh

      borsh action_code: :u8,
            method_name: :string,
            args: :string,
            gas: :u64,
            amount: :u128

      def initialize(method_name, args, gas: 100_000_000_000_000, amount: 0)
        @method_name = method_name
        @args = args.is_a?(::String) ? args : args.to_json
        @gas = gas
        @amount = amount
      end

      private

      attr_reader :method_name, :args, :gas, :amount

      def action_code
        2
      end
    end
  end
end
