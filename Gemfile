source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.0'
# Use postgres as the database for Active Record
gem 'pg'
# Use Puma as the app server
gem 'puma', '~> 3.12'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'




#Boostrap gems
gem 'bootstrap', '~> 4.1.3'
gem 'bootstrap-sass', '~> 3.3.6'
gem 'bootstrap_form'

gem 'jquery-rails'

gem 'paypal-sdk-rest'
gem 'travis'

#Visualize db
group :development do
  gem 'rails_db', '2.1.1'
end

#save current db to db/seeds.rb
gem 'seed_dump'

#generate YAML diagram of models
#usage 
#bundle exec rails g erd:install
#bundle exec rails db:migrate
gem 'rails-erd', group: :development

#for getting magic the gathering card info
gem 'mtg_sdk'

#city state gem
gem 'city-state'

gem 'countries'

#autocomplete
gem 'rails-jquery-autocomplete'

gem "font-awesome-rails"

gem 'devise'
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
end

group :test, :development do
  # Adds support for Capybara system testing and selenium driver
  gem 'rspec-rails', '4.0.0.beta3'
  gem 'faker'
  gem 'factory_bot_rails'
  gem 'capybara', '>= 2.15'
  gem 'database_cleaner'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# load environment variables
gem 'dotenv-rails'
