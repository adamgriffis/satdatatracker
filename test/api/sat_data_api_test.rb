class SatDataApiTest < ActionDispatch::IntegrationTest

  test "GET /api/stats returns stats for the last 5 min" do
    create_sat_data_for_stats

    get "/api/stats"

    expected_stats = expected_sat_data_stats
    
    assert_response :success
    assert !response.body.nil?

    assert JSON.parse(response.body)['min'] == expected_stats[:min].to_s
    assert JSON.parse(response.body)['max'] == expected_stats[:max].to_s
    assert JSON.parse(response.body)['average'].to_f.round(10) == expected_stats[:average].round(10)
  end

  test "GET /api/health returns A-OK if last 60 seconds > 160, previous > 160" do
    FactoryBot.create(:satellite_datum, timestamp: 10.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 30.seconds.ago, altitude: 1659.29)

    FactoryBot.create(:satellite_datum, timestamp: 70.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 95.seconds.ago, altitude: 2000.29)
    get "/api/health"
    
    assert_response :success
    assert !response.body.nil?

    assert response.body == "\"#{SatelliteTrackerApi::SatDataApi::HEALTHY_MESSAGE}\""
  end

  test "GET /api/health returns recovering if last 60 seconds > 160, previous < 160" do
    FactoryBot.create(:satellite_datum, timestamp: 10.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 30.seconds.ago, altitude: 1659.29)

    FactoryBot.create(:satellite_datum, timestamp: 70.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 95.seconds.ago, altitude: 161.29)
    get "/api/health"
    
    assert_response :success
    assert !response.body.nil?

    assert response.body == "\"#{SatelliteTrackerApi::SatDataApi::RECOVERING_MESSAGE}\""
  end

  test "GET /api/health returns doom if last 60 seconds < 160, reagardless previous" do
    FactoryBot.create(:satellite_datum, timestamp: 10.seconds.ago, altitude: 2.452) 
    FactoryBot.create(:satellite_datum, timestamp: 30.seconds.ago, altitude: 165.29)

    get "/api/health"
    
    assert_response :success
    assert !response.body.nil?

    assert response.body == "\"#{SatelliteTrackerApi::SatDataApi::DOOM_MESSAGE}\""
  end
end
