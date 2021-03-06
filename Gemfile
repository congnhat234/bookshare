source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

ruby "2.4.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem "activerecord-session_store"
gem "elasticsearch-rails", git: "git://github.com/elastic/elasticsearch-rails.git", branch: "5.x"
gem "elasticsearch-model"
gem "carrierwave"
gem "ckeditor"
gem "classifier-reborn"
gem "config"
gem "devise", ">= 4.7.1"
gem "faker"
gem "friendly_id"
gem "i18n-js"
gem "kaminari"
gem "mini_magick"
gem "money"
gem "omniauth"
gem "omniauth-facebook"
gem "pnotify-rails"
gem "public_activity"
gem "rails", "~> 5.1.7"
gem "rails-i18n"
# Use Redis adapter to run Action Cable in production
gem "redis"
gem "redis-namespace"
gem "redis-rails"
gem "redis-rack-cache"
gem "sidekiq"
gem "recommendable"
gem "rubocop", "~> 0.54.0", require: false
# Use Puma as the app server
gem "puma"
# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"
gem "searchkick"
# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem "webpacker"
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.2"
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem "turbolinks", "~> 5"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.5"
gem "jquery-rails"

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem "byebug", platforms: %i(mri mingw x64_mingw)
  gem "pry"
  # Adds support for Capybara system testing and selenium driver
  gem "capybara", ">= 2.15"
  gem "mysql2"
  gem "selenium-webdriver"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
  gem "web-console", ">= 3.3.0"
end

group :production do
  gem "pg", "0.20.0"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i(mingw mswin x64_mingw jruby)
