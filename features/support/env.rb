require 'cucumber/rails'

ActionController::Base.allow_rescue = false

begin
  DatabaseCleaner.strategy = :transaction
rescue NameError
  raise "You need to add database_cleaner to your Gemfile (in the :test group) if you wish to use it."
end

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Cucumber::Rails::Database.javascript_strategy = :truncation
