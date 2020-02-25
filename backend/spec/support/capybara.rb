require 'billy/capybara/rspec'
require "capybara/rspec"
require "capybara/dsl"

Capybara.javascript_driver = :selenium_billy # Uses Firefox

Billy.configure do |config|
  config.cache = true
  config.cache_path = 'spec/fixtures/features' # remove to get fresh mocks
  config.cache_request_body_methods = ['post', 'get', 'put']
  config.ignore_params = []
  config.logger = nil # comment to see logs
  config.non_successful_cache_disabled = false
  config.non_successful_error_level = :warn
  config.non_whitelisted_requests_disabled = true
  config.persist_cache = true
end