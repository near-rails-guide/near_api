# frozen_string_literal: true

module NearApi
  module Permissions
    class FunctionCallPermission
      include Borsh

      borsh permission_code: :u8,
            allowance: :u128,
            receiver_id: :string,
            method_names: [:string]

      def initialize(allowance, receiver_id, method_names)
        @allowance = allowance
        @receiver_id = receiver_id
        @method_names = method_names
      end

      private

      attr_reader :allowance, :receiver_id, :method_names

      def permission_code
        0
      end
    end
  end
end
