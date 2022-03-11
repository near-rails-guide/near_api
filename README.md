![tests](https://github.com/near-rails-guide/near_api/actions/workflows/ci.yml/badge.svg)
# NearApi

[Near Protocol API](https://docs.near.org/docs/api/overview) ruby library

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'near_api'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install near_api

## Configuration

Via ENV variables:
- `NEAR_NODE_URL` RPC node url (for ex. `https://rpc.mainnet.near.org`) 
- `NEAR_SIGNER_ID` account name for transactions and `view_access_key` requests (`account_id` in `.near-credentials`)
- `NEAR_KEYPAIR` base58 encoded private + public keys (`ed25519:4556s...` in `.near-credentials` named as `private_key` )
if no private key is available public key can be specified as `NEAR_PUBLIC_KEY` for view requests

Via explicit params:
example:
```ruby
key = NearApi::Key.new('account_id.testnet', key_pair: 'ed25519:4556s...')
config = NearApi::Config.new(node_url: 'https://rpc.testnet.near.org') 
NearApi::Transaction.new(..., key: key, config: config)
```

## Usage

Operations:
- [View](#view)
- [Transaction](#transaction)

#### `View`
NearApi::Api instance view methods:
- [view_access_key](https://docs.near.org/docs/api/rpc/access-keys#view-access-key)
- [view_access_key_list](https://docs.near.org/docs/api/rpc/access-keys#view-access-key-list)
- [view_account](https://docs.near.org/docs/api/rpc/contracts#view-account)

example:
```ruby
NearApi::Api.new.view_access_key('account_id.testnet')
```
Response: hash as described in NEAR Protocol JS API

Other [methods](https://docs.near.org/docs/api/rpc/access-keys#view-access-key-changes-single) can be called as:
```ruby
NearApi::Api.new.json_rpc('EXPERIMENTAL_changes', {
  "changes_type": "single_access_key_changes",
  "keys": [
    {
      "account_id": "example-acct.testnet",
      "public_key": "ed25519:25KEc7t7MQohAJ4EDThd2vkksKkwangnuJFzcoiXj9oM"
    }
  ],
  "finality": "final"
}
)
```

#### Smart contract view function
[query smart contract](https://docs.near.org/docs/api/rpc/contracts#call-a-contract-function)

```ruby
NearApi::Query.new.call(
  'account_id.testnet',
  'get_num',
  {}
)
```

### `Transaction`
```ruby
NearApi::Transaction.new(
  'account_id.testnet', # Transaction call receiver
  [NearApi::Actions::FunctionCall.new('increment', {})], # Array of Actions 
  key: key, # Optional key 
  config: config # Optional config
).call
```

The example above is waiting for [transaction complete](https://docs.near.org/docs/api/rpc/transactions#send-transaction-await)

To send transaction [async](https://docs.near.org/docs/api/rpc/transactions#send-transaction-async):
```ruby
NearApi::Transaction.new(...).async
```

Transaction has one or many actions
Actions:
- Create Account 
- Deploy Contract
- Function Call
- Transfer
- Stake
- Add Key
- Delete Key
- Delete Account

[Specs](https://github.com/near-rails-guide/near_api/tree/master/spec/near_api/actions)

#### Transaction status
[Transaction_status](https://docs.near.org/docs/api/rpc/transactions#transaction-status)
```ruby
NearApi::Status.new.transaction_status(transaction_hash)
```
[Transaction Status with Receipts](https://docs.near.org/docs/api/rpc/transactions#transaction-status-with-receipts)
```ruby
NearApi::Status.new.final_transaction_status(transaction_hash)
```

#### External Signing
To sign transaction with external signing service (dedicated secure service or hardware ledger)
```ruby
transaction = NearApi::Transaction.new(...)
digest = transaction.message.digest
# sign with external service 
signature = Ed25519::SigningKey.from_keypair(bytestring).sign(digest)
transaction.call_api('broadcast_tx_commit', transaction.message.message, signature)
```

## Contributing
Bug reports and pull requests are welcome on GitHub at https://github.com/near-rails-guide/near_api

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
