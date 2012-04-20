source 'http://rubygems.org'

gem 'rails', '3.2.3'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# DB
gem 'bson_ext'
gem 'mongoid'

# Auth
# gem 'omniauth'
gem "net-ldap"
gem "ssedap-client"

gem 'settingslogic'

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', ">= 1.0.3"
end
group :production do
  gem 'therubyracer'
end

gem 'jquery-rails'

# Testing
gem 'cucumber-rails', :group => [:test]
gem 'capybara', :group => [:development, :test]
gem 'rspec-rails', :group => [:development, :test]
gem 'factory_girl_rails', :group => [:development, :test]

# Use unicorn as the web server
gem 'unicorn'

# Deploy with Capistrano
gem 'whiskey_disk', group: :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

