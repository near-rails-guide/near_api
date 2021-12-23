# frozen_string_literal: true

class NearApi::Status
  def initialize(config = NearApi.config)
    @api = NearApi::Api.new(config)
  end

  def transaction_status(transaction_hash, key: NearApi.key)
    params = [transaction_hash, key.signer_id]
    call_api('tx', params)
  end

  def final_transaction_status(transaction_hash, key: NearApi.key)
    params = [transaction_hash, key.signer_id]
    call_api('EXPERIMENTAL_tx_status', params)
  end

  private

  attr_reader :api

  def call_api(method, params)
    api.json_rpc(method, params)
  end
end
