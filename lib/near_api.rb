# frozen_string_literal: true

require 'uri'
require 'net/https'
require 'json'
require 'base64'
require 'borsh'
require_relative 'near_api/version'
require_relative 'near_api/key'
require_relative 'near_api/status'
require_relative 'near_api/transaction'
require_relative 'near_api/access_key'
require_relative 'near_api/api'
require_relative 'near_api/query'
require_relative 'near_api/actions/add_key'
require_relative 'near_api/actions/create_account'
require_relative 'near_api/actions/function_call'
require_relative 'near_api/actions/transfer'
require_relative 'near_api/actions/delete_account'
require_relative 'near_api/actions/deploy_contract'
require_relative 'near_api/config'
require_relative 'near_api/permissions/full_access_permission'
require_relative 'near_api/permissions/function_call_permission'
require_relative 'near_api/base58'
require_relative 'near_api/yocto'

module NearApi
  class Error < StandardError; end

  def self.config
    @config ||= Config.new
  end

  def config=(config)
    @config = config
  end

  def self.key
    @key ||= Key.new
  end

  def key=(key)
    @key = key
  end
end
