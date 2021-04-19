class TrackSatDataJob < ApplicationJob
  queue_as :default

  def perform
    sat_data = NestioSatClient.get_stat_data

    if sat_data # actually got data back, try to consume it
      timestring = sat_data['last_updated']

      timestamp = ActiveSupport::TimeZone["UTC"].parse(timestring) # the timestring that comes back doesn't not contain 
      # timezone info, so we need to force it to be UTC (the server TZ should be UTC so this is irrelevant but for local 
      # testing and to make absolutely sure we do this)

      data = SatelliteDatum.ensure_sat_data(timestamp, sat_data['altitude'])

      # I'm on heroku's free tier, they've got me limited to 10000 rows, which works out to be about a days data, so clear out anything older than 24 hours
      SatelliteDatum.clear_older_than_day
    end
  end
end
