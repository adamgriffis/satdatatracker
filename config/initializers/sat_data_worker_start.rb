# launch the satellite data continuous watcher
InitializerHelpers.skip_console_rake_generators do
   Thread.new do

    loop do
      # the rails scheduled jobs solutions don't work at the 5 second level, so just have this guy continuously running
      TrackSatDataJob.perform_later

      sleep 5
    end
  end
end
