class TrackSatDataJob < ApplicationJob
  queue_as :default

  def perform
    sat_data = NestioSatClient.get_stat_data

    if sat_data # actually got data back, try to consume it
      timestring = sat_data['last_updated']

      unless timestring.include?("+")# the date is coming in w/o time zone, it looks like it's in UTC but it's not specified, so force the server to know it's in UTC
        # if both servers are in UTC this won't matter, but I thought it better to be explici
        timestring += "+00:00"
      end

      timestamp = Time.parse(timestring)

      data = SatelliteDatum.ensure_sat_data(timestamp, sat_data['altitude'])

      # I'm on heroku's free tier, they've got me limited to 10000 rows, which works out to be about a days data, so clear out anything older than 24 hours
      SatelliteDatum.clear_older_than_day
    end
  end
end
