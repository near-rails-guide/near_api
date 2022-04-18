# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NearApi::Actions::DeployContract do
  include_context :shared_methods

  subject(:deploy_contract) do
    NearApi::Transaction.new(
      account_id,
      NearApi::Actions::DeployContract.new(contract),
      key: account_key
    ).call
  end

  let(:contract) { File.read('spec/fixtures/rust_counter_tutorial.wasm', encoding: 'ASCII-8BIT') }
  let(:contract_call) do
    NearApi::Transaction.new(
      account_id,
      NearApi::Actions::FunctionCall.new('increment', {}),
      key: account_key
    ).call
  end

  around(:each) do |example|
    create_account
    example.run
  ensure
    delete_account
  end

  it 'deploys contract' do
    expect(deploy_contract.dig('result', 'status', 'SuccessValue')).to eq('')
    expect(
      contract_call.dig('result', 'receipts_outcome').first.dig('outcome', 'logs').first
    ).to eq('Increased number to 1')
  end
end
