# frozen_string_literal: true

RSpec.shared_context :shared_methods do
  let(:account_id) { "#{SecureRandom.hex}.#{NearApi.key.signer_id}" }
  let(:account_key) do
    NearApi::Key.new(account_id, key_pair: NearApi::Base58.encode(Ed25519::SigningKey.generate.keypair))
  end

  let(:create_account) do
    NearApi::Transaction.new(
      account_id,
      [
        NearApi::Actions::CreateAccount.new,
        NearApi::Actions::AddKey.new(account_key, NearApi::Permissions::FullAccessPermission.new),
        NearApi::Actions::Transfer.new(near_amount: 1)
      ]
    ).call
  end

  let(:delete_account) do
    NearApi::Transaction.new(
      account_id, NearApi::Actions::DeleteAccount.new(NearApi.key.signer_id), key: account_key
    ).call
  end
end
