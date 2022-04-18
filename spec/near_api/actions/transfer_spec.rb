# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NearApi::Actions::Transfer do
  include_context :shared_methods

  subject(:transfer) do
    NearApi::Transaction.new(
      account_id,
      NearApi::Actions::Transfer.new(near_amount: 1)
    ).call
  end

  around(:each) do |example|
    create_account
    example.run
  ensure
    delete_account
  end

  it 'transfers amount to account' do
    expect { transfer }.to change {
      NearApi::Yocto.to_near(NearApi::Api.new.view_account(account_id).dig('result', 'amount'))
    }.by(1)
  end
end
