source "https://rubygems.org"

gem 'rails', '4.2.5'
gem 'mysql2'

gem 'byebug'
group :assets do
  gem 'sass-rails', "5.0.4"
  gem 'coffee-rails', "4.1.0"
end

## TODO - decide the gem dependency.
gem 'spree', '3.0.4'

## TODO - Remove.
# gem 'spree_html_invoice' , :git => 'git://github.com/dancinglightning/spree-html-invoice.git'

# Provides basic authentication functionality for testing parts of your engine
gem 'spree_auth_devise', github: 'spree/spree_auth_devise', branch: '3-0-stable'

gemspec

group :test do
  gem 'factory_girl_rails', '~> 4.5.0'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
  gem 'database_cleaner'
  gem 'rspec-html-matchers'
end
