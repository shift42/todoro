source "https://rubygems.org"

# Specify your gem's dependencies in todoro.gemspec.
gemspec

gem "puma"

gem "pg"

gem "propshaft"

# Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
gem "rubocop-rails-omakase", require: false
gem "rdoc"

# Start debugger with binding.b [https://github.com/ruby/debug]
# gem "debug", ">= 1.0.0"

group :test, :development do
  gem "pry"
end

group :test do
  gem "factory_bot_rails"
  gem "rspec-rails", "~> 7.1"
end

gem "turbo-rails", "~> 2.0"
