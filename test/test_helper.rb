ENV['RAILS_ENV'] ||= 'test'
require_relative "../config/environment"
require "rails/test_help"

require 'factory_bot_rails'

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  def create_sat_data_for_stats
    FactoryBot.create(:satellite_datum, timestamp: 2.minutes.ago, altitude: 2.452) # our min
    FactoryBot.create(:satellite_datum, timestamp: 4.minutes.ago, altitude: 100.929) # our max

    FactoryBot.create(:satellite_datum, timestamp: 100.seconds.ago, altitude: 20.23)
    FactoryBot.create(:satellite_datum, timestamp: 125.seconds.ago, altitude: 5.23)
    FactoryBot.create(:satellite_datum, timestamp: 75.seconds.ago, altitude: 7.77)
    FactoryBot.create(:satellite_datum, timestamp: 65.seconds.ago, altitude: 8.243)
    FactoryBot.create(:satellite_datum, timestamp: 3.seconds.ago, altitude: 50.555)    
  end

  def expected_sat_data_stats
    {min: 2.452, max: 100.929, average: ((100.929 + 2.452 + 20.23 + 5.23 + 7.77 + 8.243 + 50.555) / 7.0).round(10)}
  end

  # Add more helper methods to be used by all tests here...
end
