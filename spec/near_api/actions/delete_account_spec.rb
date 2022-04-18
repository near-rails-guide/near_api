# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NearApi::Actions::DeleteAccount do
  include_context :shared_methods

  subject(:delete_account) do
    NearApi::Transaction.new(
      account_id, NearApi::Actions::DeleteAccount.new(NearApi.key.signer_id), key: account_key
    ).call
  end

  before { create_account }

  it 'deletes account' do
    view_account_response = NearApi::Api.new.view_account(account_id)
    expect(view_account_response['result'].keys).to eq(
      ['amount', 'block_hash', 'block_height', 'code_hash', 'locked', 'storage_paid_at', 'storage_usage']
    )

    expect(delete_account.dig('result', 'status', 'SuccessValue')).to eq('')

    view_account_response2 = NearApi::Api.new.view_account(account_id)
    expect(view_account_response2.dig('error', 'cause', 'name')).to eq('UNKNOWN_ACCOUNT')
  end
end
