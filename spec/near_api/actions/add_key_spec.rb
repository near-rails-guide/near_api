# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NearApi::Actions::AddKey do
  include_context :shared_methods

  subject(:add_key) do
    NearApi::Transaction.new(
      account_id,
      NearApi::Actions::AddKey.new(account_key2, NearApi::Permissions::FullAccessPermission.new),
      key: account_key
    ).call
  end

  let(:account_key2) do
    NearApi::Key.new(account_id, key_pair: NearApi::Base58.encode(Ed25519::SigningKey.generate.keypair))
  end

  around(:each) do |example|
    create_account
    example.run
  ensure
    delete_account
  end

  it 'adds key to account' do
    expect { add_key }.to change {
      NearApi::Api.new.view_access_key_list(account_id).dig('result', 'keys').size
    }.from(1).to(2)
  end
end
