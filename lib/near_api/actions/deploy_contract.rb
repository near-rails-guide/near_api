# frozen_string_literal: true

module NearApi
  module Actions
    class DeployContract
      include Borsh

      borsh action_code: :u8,
            contract: :string

      def initialize(contract)
        @contract = contract
      end

      private

      attr_reader :contract

      def action_code
        1
      end
    end
  end
end
