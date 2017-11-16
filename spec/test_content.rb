def test_order_request
  {
    idempotency_key: "123456-2",
    variants: [
      {
        id: 14,
        quantity: 1
      }
    ],
    email: "john@example.com",
    ship_address: {
      firstname: "John",
      lastname: "Smith",
      address1: "321 Fairmount St.",
      address2: null,
      zipcode: "90210",
      city: "Los Angeles",
      state: "CA",
      country: "US",
      phone: "5551230101"
    },
    bill_address: {
      firstname: "Jane",
      lastname: "Smith",
      address1: "321 Fairmount St.",
      address2: null,
      zipcode: "90210",
      city: "Los Angeles",
      state: "CA",
      country: "US",
      phone: "5551234567"
    },
    webhooks: {
      order_placed: "https://example.com/hollar/order_placed",
      order_failed: "https://example.com/hollar/order_failed",
      order_shipped: "https://example.com/hollar/order_shipped",
      order_delivered: "https://example.com/hollar/order_delivered",
      tracking_obtained: "https://example.com/hollar/tracking_obtained"
    }
  }
end

def test_order_create_response
  {
    "status": 201,
    "data": {
      "id": 123,
      "number": "R395689365"
    }
  }
end

def test_order_status_response
  {
    "id": 123,
    "number": "R395689365",
    "email": "john@example.com",
    "placed_at": "2017-10-02T23:51:08.366Z",
    "prices": {
      "merchandise": 400,
      "fulfillment": 25,
      "shipping": 75,
      "adjustment": -25,
      "tax": 25,
      "total": 500
    },
    "tracking": {
      "carrier": "Fedex",
      "tracking_number": "9261290100129790891234",
      "obtained_at": "2017-10-03T23:22:48.165Z"
    }
  }
end