# frozen_string_literal: true

require 'spec_helper'

RSpec.describe NearApi::Query do
  include_context :shared_methods

  subject(:response) do
    NearApi::Query.new.call(
      account_id,
      'get_num',
      {}
    )
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

  it 'reads from the contract' do
    expect(response['result']['result'].pack('c*')).to eq('0')
  end
end
