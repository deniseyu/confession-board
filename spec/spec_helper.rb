ENV["RACK_ENV"] = 'test'

require 'capybara/rspec'
require 'capybara' 
require './app/router'
require 'database_cleaner'
require 'launchy'

Capybara.app = ConfessionBoard 


RSpec.configure do |config|
  
  config.run_all_when_everything_filtered = true
  config.filter_run :focus
  config.expect_with :rspec do |expectations|

    config.before(:suite) do
      DatabaseCleaner.strategy = :transaction
      DatabaseCleaner.clean_with(:truncation)
    end

    config.before(:each) do
      DatabaseCleaner.start 
    end

    config.after(:each) do
      DatabaseCleaner.clean
    end

    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
    end

  end


