# frozen_string_literal: true

module NearApi
  module Actions
    class CreateAccount
      include Borsh

      borsh action_code: :u8

      private

      def action_code
        0
      end
    end
  end
end
