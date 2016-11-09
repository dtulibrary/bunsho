source 'https://rubygems.org'

gem 'rails', '~> 3.2.0'
gem 'jquery-rails', '~> 2.3.0'
gem 'activeadmin'
gem 'devise_cas_authenticatable'
gem 'validates_timeliness'
gem 'uuidtools'
gem 'capistrano', '~> 2.15'
gem 'bootstrap-sass', '~> 3.1.1'

group :assets do
  gem 'sass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'therubyracer', :platforms => :ruby
  gem 'uglifier', '>= 1.0.3'
  #gem 'turbo-sprockets-rails3'
  gem 'findit_font', :git => 'git://github.com/dtulibrary/findit_font.git'
end

group :test do
  gem 'simplecov', :require => false
  gem 'simplecov-html', :require => false
  gem 'simplecov-rcov', :require => false
  gem 'mocha', :require => false
  gem 'factory_girl_rails'
  gem 'webmock'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'sqlite3'
  # Static analysis for security vulnerabilities.
  gem 'brakeman', :require => false
end

group :development do
  gem 'rails_best_practices'
  gem 'byebug'
end

group :staging, :production do
  gem 'pg'
end
