source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.2.0"

gem "rails", "~> 7.0.4"
gem "sqlite3", "~> 1.4"
gem "puma", "~> 5.0"
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
gem "bootsnap", require: false
gem "httparty"

group :development do
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'shoulda-matchers'
end

