# frozen_string_literal: true

class NearApi::Status
  STATUSES = [
    # Transaction is waiting to be included into the block
    NONE = 'NONE',

    # Transaction is included into the block. The block may be not finalized yet
    INCLUDED = 'INCLUDED',

    # Transaction is included into the block +
    # All non-refund transaction receipts finished their execution.
    # The corresponding blocks for tx and each receipt may be not finalized yet
    EXECUTED_OPTIMISTIC = 'EXECUTED_OPTIMISTIC',

    # Transaction is included into finalized block
    INCLUDED_FINAL = 'INCLUDED_FINAL',

    # Transaction is included into finalized block +
    #  All non-refund transaction receipts finished their execution.
    #  The corresponding blocks for each receipt may be not finalized yet
    EXECUTED = 'EXECUTED',

    # Transaction is included into finalized block +
    # Execution of all transaction receipts is finalized, including refund receipts
    FINAL = 'FINAL'
  ].freeze

  def initialize(config = NearApi.config)
    @api = NearApi::Api.new(config)
  end

  def transaction_status(transaction_hash, wait_until: EXECUTED_OPTIMISTIC, key: NearApi.key)
    params = { tx_hash: transaction_hash, sender_account_id: key.signer_id, wait_until: wait_until }
    call_api('tx', params)
  end

  def transaction_status_with_receipts(transaction_hash, wait_until: EXECUTED_OPTIMISTIC, key: NearApi.key)
    params = { tx_hash: transaction_hash, sender_account_id: key.signer_id, wait_until: wait_until }
    call_api('EXPERIMENTAL_tx_status', params)
  end

  private

  attr_reader :api

  def call_api(method, params)
    api.json_rpc(method, params)
  end
end
