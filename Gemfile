source 'https://rubygems.org'

gem 'rails'
gem 'jquery-rails'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  gem 'turbo-sprockets-rails3'
end

group :test do
  gem 'simplecov', :require => false
  gem 'simplecov-html', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'mocha', :require => false
  gem 'factory_girl_rails'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
  # Static analysis for security vulnerabilities.
  gem 'brakeman', :require => false
end

group :development do
  gem 'rails_best_practices'
  gem 'debugger'
end

group :staging, :production do
  gem 'pg'
end
