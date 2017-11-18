require 'json'
require 'rest_client'
require 'hollar/order'
require 'hollar/errors/authentication_error'

module Hollar
  @@api_token = nil
  @@base_url = "https://www.hollar.com/fulfillment/v1/"

  def self.api_token=(token)
    @@api_token = token
  end

  def self.api_token
    @@api_token
  end

  def self.base_url=(url)
    @@base_url = url
  end

  def self.base_url
    @@base_url
  end

  def self.request(method, url, params)
    raise AuthenticationError unless api_token
    raise ArgumentError if params.nil? || params.empty? && method == :post

    opts = {
        :method => method,
        :token => api_token,
        :url => url
    }

    if method == :get
      opts.merge!({headers: {params: params}})
    else
      opts.merge!(:payload => params.to_json)
    end

    response = execute_request(opts)
    return JSON.parse(response)
  end

  private

  def self.execute_request(opts)
    RestClient::Request.execute(opts)
  end
end