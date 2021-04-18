require "test_helper"

class SatelliteDatumTest < ActiveSupport::TestCase
  test "SatelliteDatum.status gives us a min, max and average of the last 5 min" do
    create_sat_data_for_stats

    stats = SatelliteDatum.stats

    expected_stats = expected_sat_data_stats

    assert stats[:min] == expected_stats[:min]
    assert stats[:max] == expected_stats[:max]
    assert stats[:average].round(10) == expected_stats[:average]
  end

  test "block healhty returns true if average > 160" do 
    FactoryBot.create(:satellite_datum, timestamp: 2.minutes.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 3.minutes.ago, altitude: 10000.929) 

    # average is very high, should be true
    assert SatelliteDatum.block_healthy?(SatelliteDatum.all)
  end

  test "block healhty returns false if average < 160" do 
    FactoryBot.create(:satellite_datum, timestamp: 2.minutes.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 3.minutes.ago, altitude: 165.929) # above 160 to make sure this is using average and not max

    # should be false
    assert !SatelliteDatum.block_healthy?(SatelliteDatum.all)
  end

  test "currently healhty returns true if last min average < 160" do 
    FactoryBot.create(:satellite_datum, timestamp: 10.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 30.seconds.ago, altitude: 1659.29)

    # should be true
    assert SatelliteDatum.currently_healthy?
  end

  test "currently healhty returns false if last min average > 160" do 
    FactoryBot.create(:satellite_datum, timestamp: 10.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 30.seconds.ago, altitude: 165.29) # above 160 to make sure this is using average and not max

    # should be true
    assert !SatelliteDatum.currently_healthy?
  end

  test "previously healhty returns true if last min average < 160" do 
    FactoryBot.create(:satellite_datum, timestamp: 70.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 90.seconds.ago, altitude: 1659.29)

    # should be true
    assert SatelliteDatum.previously_healthy?
  end

  test "previously healhty returns false if last min average > 160" do 
    FactoryBot.create(:satellite_datum, timestamp: 70.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 90.seconds.ago, altitude: 165.29) # above 160 to make sure this is using average and not max

    # should be true
    assert !SatelliteDatum.previously_healthy?
  end
end
