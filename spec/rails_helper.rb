# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'

# Checks for pending migrations and applies them before tests are run.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  # Fixture settings
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # MySQL接続エラーを回避するため、一時的にfalseに設定
  config.use_transactional_fixtures = false

  # Automatically infer spec type
  config.infer_spec_type_from_file_location!

  # Filter Rails gem lines from backtraces
  config.filter_rails_from_backtrace!
end
