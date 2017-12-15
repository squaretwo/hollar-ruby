require 'spec_helper'

describe Hollar do
  before do
    @token = "example_token"
    Hollar.api_token = @token
  end

  it 'should return the correct base url' do
    Hollar.base_url.should == "https://www.hollar.com/fulfillment/v1/"
  end

  context "get" do
    it 'returns a response object when making request' do
      params = {"foo" => "bar"}
      opts = {
          :method => :get,
          :url => Hollar.base_url + '/example',
          :headers => {params: params, "x-spree-token": @token}
      }

      RestClient::Request.should_receive(:execute).with(opts).and_return(test_order_status_response.to_json)
      response = Hollar.request(:get, Hollar.base_url + '/example', params)
      response.should == JSON.parse(test_order_status_response.to_json)
    end

    it 'raises an AuthenticationError when the api_token is not set' do
      Hollar.api_token = nil
      expect{Hollar.request(:get, Hollar.base_url + '/example', {})}.to raise_error(Hollar::AuthenticationError)
    end
  end

  context 'post' do
    it 'raises an ArgumentError when a POST request does not contain any params' do
      expect{Hollar.request(:post, Hollar.base_url + '/example', {})}.to raise_error(ArgumentError)
    end

    it 'returns a response object when making request' do
      params = {"foo" => "bar"}
      opts = {
          :method => :post,
          :url => Hollar.base_url + '/example',
          :headers => {"x-spree-token": @token, :content_type => :json},
          :payload => params.to_json
      }

      RestClient::Request.should_receive(:execute).with(opts).and_return(test_order_create_response.to_json)
      response = Hollar.request(:post, Hollar.base_url + '/example', params)
      response.should == JSON.parse(test_order_create_response.to_json)
    end
  end

end