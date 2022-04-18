# frozen_string_literal: true

module NearApi
  module Permissions
    class FullAccessPermission
      include Borsh

      borsh permission_code: :u8

      private

      def permission_code
        1
      end
    end
  end
end
