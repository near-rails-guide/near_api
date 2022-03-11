# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NearApi::Actions::FunctionCall do
  include_context :shared_methods

  subject(:function_call) do
    NearApi::Transaction.new(
      account_id,
      NearApi::Actions::FunctionCall.new('increment', {}),
      key: account_key
    ).call
  end

  let(:contract) { File.read('spec/fixtures/rust_counter_tutorial.wasm', encoding: 'ASCII-8BIT') }
  let(:deploy_contract) do
    NearApi::Transaction.new(
      account_id,
      NearApi::Actions::DeployContract.new(contract),
      key: account_key
    ).call
  end

  around(:each) do |example|
    create_account
    deploy_contract
    example.run
  ensure
    delete_account
  end

  it 'calls contract' do
    expect(
      function_call.dig('result', 'receipts_outcome').first.dig('outcome', 'logs').first
    ).to eq('Increased number to 1')
  end

  context 'with transaction hash' do
    subject(:transaction) do
      NearApi::Transaction.new(
        account_id,
        NearApi::Actions::FunctionCall.new('increment', {}),
        key: account_key
      )
    end

    it 'has transaction_hash as transaction digest' do
      expect(transaction.transaction_hash).to eq(transaction.call.dig('result', 'transaction', 'hash'))
    end
  end
end
