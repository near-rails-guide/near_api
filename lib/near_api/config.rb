# frozen_string_literal: true

class NearApi::Config
  def initialize(node_url: ENV.fetch('NEAR_NODE_URL'))
    @node_url = node_url
  end

  attr_reader :node_url
end
