module SatelliteTrackerApi
  
  class SatDataApi < Grape::API

    DOOM_MESSAGE = "WARNING: RAPID ORBITAL DECAY IMMINENT"
    RECOVERING_MESSAGE = "Sustained Low Earth Orbit Resumed"
    HEALTHY_MESSAGE = "Altitude is A-OK"

    desc "Returns the current set of stats"
    get "/stats" do 
      SatelliteDatum.stats
    end

    desc "Returns the current health of the satelite, and will indicate if it's recovering from a previous incident" 
    get "/health" do 
      if !SatelliteDatum.currently_healthy? # not currently healthy return the doom message
        return DOOM_MESSAGE
      elsif !SatelliteDatum.previously_healthy? # recovering
        return RECOVERING_MESSAGE
      else
        return HEALTHY_MESSAGE # I've been healthy at least 2 min
      end
    end
  end
end