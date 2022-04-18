# frozen_string_literal: true

module NearApi
  module Actions
    class AddKey
      include Borsh

      borsh action_code: :u8,
            public_key: { key_type: :u8, public_key: 32 },
            access_key: :borsh

      def initialize(public_key, permission)
        @public_key = public_key
        @access_key = NearApi::AccessKey.new(permission)
      end

      private

      attr_reader :public_key, :access_key

      def action_code
        5
      end
    end
  end
end
