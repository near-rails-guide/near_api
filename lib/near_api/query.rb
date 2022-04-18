# frozen_string_literal: true

class NearApi::Query
  def initialize(config = NearApi.config)
    @api = NearApi::Api.new(config)
  end

  def call(account_id, method_name, args, finality: 'optimistic')
    params = {
      account_id: account_id,
      method_name: method_name,
      finality: finality,
      request_type: 'call_function',
      args_base64: Base64.strict_encode64(args.to_json)
    }
    call_api(params)
  end

  private

  attr_reader :api

  def call_api(params)
    api.json_rpc('query', params)
  end
end
