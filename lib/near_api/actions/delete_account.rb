# frozen_string_literal: true

module NearApi
  module Actions
    class DeleteAccount
      include Borsh

      borsh action_code: :u8,
            beneficiary_id: :string

      def initialize(beneficiary_id)
        @beneficiary_id = beneficiary_id
      end

      private

      attr_reader :beneficiary_id

      def action_code
        7
      end
    end
  end
end
