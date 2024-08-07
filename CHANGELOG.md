# Change Log

## 0.3.1
- removed NearApi::Status#final_transaction_status method
- added NearApi::Status#transaction_status_with_receipts method
- updated NearApi::Status#transaction_status arguments

## 0.4.1
- refactor NearApi::Transaction, replace deprecated `broadcast_tx_async` with `send_tx`
- breaking change NearApi::Transaction#call_api arguments 
