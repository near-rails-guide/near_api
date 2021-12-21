# frozen_string_literal: true

class NearApi::Api
  def initialize(config = NearApi.config)
    @config = config
  end

  def call(method, payload)
    json_rpc(method, payload)
  end

  def status
    uri = URI("#{config.node_url}/status")
    JSON.parse(Net::HTTP.get(uri))
  end

  def view_access_key(key)
    call(
      'query',
      {
        "request_type": "view_access_key",
        "account_id": key.signer_id,
        "public_key": NearApi::Base58.encode(key.public_key),
        "finality": 'optimistic'
      }
    )
  end

  def nonce(key)
    view_access_key(key)['result']['nonce']
  end

  def block_hash
    NearApi::Base58.decode(status['sync_info']['latest_block_hash'])
  end

  def json_rpc(method, payload)
    json_rpc_payload = {
      id: 'dontcare',
      jsonrpc: "2.0",
      method: method,
      params: payload
    }

    uri = URI.parse(config.node_url)
    req = Net::HTTP::Post.new(uri.to_s)
    req.body = json_rpc_payload.to_json
    req['Content-Type'] = 'application/json'
    response = Net::HTTP.new(uri.host, uri.port).tap { |http| http.use_ssl = true }.request(req)

    JSON.parse(response.body)
  end

  private

  attr_reader :config
end

