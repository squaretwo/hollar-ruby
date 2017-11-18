module Hollar
  class Order
    def self.create(order_details = {})
      order = Order.new
      response = Hollar.request(:post, self.url, order_details)
      if (response)
        order.set_values(response)
      end
      order
    end

    def self.get(id)
      order = Order.new
      response = Hollar.request(:get, self.url + "/#{id}", {})
      if (response)
        order.set_values(response)
      end
      order
    end

    def self.cancel(id, params = {})
      order = Order.new
      response = Hollar.request(:post, self.url + "/#{id}/cancel", params)
      if (response)
        order.set_values(response)
      end
      order
    end

    def self.url
      Hollar.base_url + 'orders'
    end

    def set_values(values)
      @values = values
      if values.has_key?("data")
        @values.merge!(values["data"])
        @values.delete("data")
      end
    end

    def method_missing(name, *args)
      @values ||= {}
      if name.to_s.end_with?('=')
        @values[name.to_s] = args[0]
      else
        @values[name.to_s]
      end
    end
  end
end
