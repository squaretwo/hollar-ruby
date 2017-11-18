require 'spec_helper'

describe Hollar::Order do
  before do
    @token = "example_token"
    Hollar.api_token = @token
  end

  it 'should return the correct url' do
    Hollar::Order.url.should == "https://www.hollar.com/fulfillment/v1/orders"
  end

  context '#create' do
    it 'should return a new Hollar::Order instance populated with order data' do
      expected_opts = {:method => :post, :url => Hollar::Order.url, :token => Hollar.api_token, :payload => test_order_create_request.to_json}
      Hollar.should_receive(:execute_request).with(expected_opts).and_return(test_order_create_response.to_json)
      order = Hollar::Order.create(test_order_create_request)

      order.status.should == test_order_create_response[:status]
      order.id.should == test_order_create_response[:data][:id]
      order.number.should == test_order_create_response[:data][:number]
    end

    it 'should return a new Hollar::Order instance with error data' do
      expected_opts = {:method => :post, :url => Hollar::Order.url, :token => Hollar.api_token, :payload => test_order_create_request.to_json}
      Hollar.should_receive(:execute_request).with(expected_opts).and_return(test_error_response.to_json)
      order = Hollar::Order.create(test_order_create_request)
      order._type.should == test_error_response[:_type]
      order.code.should == test_error_response[:code]
      order.message.should == test_error_response[:message]
      order.order_id.should == test_error_response[:data][:order_id]
    end
  end

  context '#cancel' do
    it 'should call the hollar cancel api endpoint' do
      expected_opts = {:method => :post, :url => Hollar::Order.url + "/1/cancel", :token => Hollar.api_token, :payload => test_order_cancel_request.to_json}
      Hollar.should_receive(:execute_request).with(expected_opts).and_return(test_order_cancel_response.to_json)
      order = Hollar::Order.cancel(1, test_order_cancel_request)
      order.status.should === test_order_cancel_response[:status]
    end
  end

  context '#get' do
    it 'should return a new Hollar::Order instance with the order data' do
      expected_opts = {:method => :get, :url => Hollar::Order.url + "/#{test_order_status_response[:data][:id]}", :token => Hollar.api_token, :headers => {params: {}}}
      Hollar.should_receive(:execute_request).with(expected_opts).and_return(test_order_status_response.to_json)
      order = Hollar::Order.get(test_order_status_response[:data][:id])

      order.status.should == test_order_status_response[:status]
      order.id.should == test_order_status_response[:data][:id]
      order.number.should == test_order_status_response[:data][:number]
      order.placed_at.should == test_order_status_response[:data][:placed_at]

      order.prices["merchandise"].should == test_order_status_response[:data][:prices][:merchandise]
      order.tracking["carrier"].should == test_order_status_response[:data][:tracking][:carrier]
    end
  end
end
