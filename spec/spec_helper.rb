require "bundler/setup"
require "owmo"

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.add_setting :api_key
  config.api_key = "d33b4df8a76def8a9846d6dc1a5c9fa9"
end
