ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "simplecov"
require "faker"
require "factory_bot_rails"


class ActiveSupport::TestCase
  include FactoryBot::Syntax::Methods


  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors, with: :threads)
  SimpleCov.start do
    add_filter '/test/'
    track_files 'app/**/*.rb'
  end
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
