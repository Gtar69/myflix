source "https://rubygems.org"
ruby '2.1.4' # or other from link above

gem 'bootstrap-sass'
gem 'coffee-rails'
gem 'rails', '4.1.1'
gem 'haml-rails'
gem 'sass-rails'
gem 'uglifier'
gem 'jquery-rails'
gem 'pg'
gem 'bootstrap_form'
gem 'bcrypt', '~>3.1.7'
gem 'fabrication'
gem 'faker'
gem "sidekiq"
gem "unicorn"


group :development do
  gem 'thin'
  gem "better_errors"
  gem "binding_of_caller"
  gem "letter_opener"
  gem "sinatra", require: false
  gem "slim"
end

group :development, :test do
  gem 'pry'
  gem 'pry-nav'
  gem 'rspec-rails', '2.99'
end


group :test do
  gem 'database_cleaner', '1.2.0'
  gem 'shoulda-matchers'
  gem 'capybara'
  gem 'launchy'
  gem 'capybara-email'
end

group :production do
  gem 'rails_12factor'
end

