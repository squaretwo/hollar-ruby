require 'json'
require 'rest_client'
require 'hollar'
require 'hollar/errors/authentication_error'
require 'test_content'

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.syntax = [:should, :expect]
  end
end