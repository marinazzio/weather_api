require "vcr"
require "webmock/rspec"

VCR.configure do |config|
  config.cassette_library_dir = "spec/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = true

  config.filter_sensitive_data('<ACCU_WEATHER_API_KEY>') { ENV['ACCU_WEATHER_API_KEY'] }
  config.debug_logger = File.open('log/vcr.log', 'w')
end
