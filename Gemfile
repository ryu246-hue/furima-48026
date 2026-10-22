source "https://rubygems.org"

ruby ">= 3.2.0", "< 3.3.0"

gem "rails", "~> 7.1.0"
gem "sprockets-rails"
gem "mysql2", "~> 0.5"

group :production do
  gem "pg"
end

gem "puma", ">= 5.0"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "jbuilder"
gem "tzinfo-data", platforms: %i[windows jruby]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[mri windows]
  gem "rspec-rails", "~> 4.0.0"
  gem "factory_bot_rails"
  gem "faker"
end

group :development do
  gem "web-console"
  gem "rubocop", "1.71.2", require: false
end

group :test do
  gem "capybara"
  gem "selenium-webdriver"
end

gem "devise", "~> 5.0"
gem "active_hash"
gem "payjp"