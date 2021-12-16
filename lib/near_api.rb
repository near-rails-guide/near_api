# frozen_string_literal: true

require 'uri'
require 'net/https'
require 'json'
require "base64"
require 'borsh'
require_relative "near_api/version"
require_relative "near_api/key_pair"
require_relative "near_api/action"
require_relative "near_api/action/function_call"
require_relative "near_api/config"
require_relative "near_api/api"
require_relative "near_api/base58"

module NearApi
  class Error < StandardError; end
  # Your code goes here...
end
