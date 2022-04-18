# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NearApi::Actions::CreateAccount do
  include_context :shared_methods

  subject(:create_account) do
    NearApi::Transaction.new(
      account_id,
      [
        NearApi::Actions::CreateAccount.new,
        NearApi::Actions::AddKey.new(account_key, NearApi::Permissions::FullAccessPermission.new),
        NearApi::Actions::Transfer.new(near_amount: 1)
      ]
    ).call
  end

  it 'creates account' do
    expect(create_account.dig('result', 'status', 'SuccessValue')).to eq('')

    view_account_response = NearApi::Api.new.view_account(account_id)
    expect(view_account_response['result'].keys).to eq(
      ['amount', 'block_hash', 'block_height', 'code_hash', 'locked', 'storage_paid_at', 'storage_usage']
    )

    expect(delete_account.dig('result', 'status', 'SuccessValue')).to eq('')
  end
end
