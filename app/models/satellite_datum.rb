class SatelliteDatum < ApplicationRecord
  validates_presence_of  :altitude
  validates_presence_of  :timestamp # no point in having a duplicate timestamp, no point in having a record without at timestam and altitude
  validates :timestamp, uniqueness: true

  MINIMUM_SAFE_ALTITUDE = 160

  def self.stats
    last_five = self.where('timestamp >= ?', 5.minutes.ago)

    min = last_five.minimum(:altitude)
    max = last_five.maximum(:altitude)
    average = last_five.average(:altitude)

    {min: min, max: max, average: average}
  end

  def self.ensure_sat_data(timestamp, altitude)
    data = self.where(timestamp: timestamp).first 
    unless data # only record if it's data we haven't recorded yet
      self.create!(timestamp: timestamp, altitude: altitude)
    end
  end

  def self.clear_older_than_day
    self.where('timestamp < ?', 24.hours.ago).delete_all
  end

  def self.block_healthy?(data_block)
    data_block.average(:altitude) >= MINIMUM_SAFE_ALTITUDE
  end

  def self.currently_healthy?
    block_healthy?(self.where('timestamp > ?', 1.minute.ago))
  end

  def self.previously_healthy?
    block_healthy?(self.where('timestamp > ? and timestamp < ?', 2.minutes.ago, 1.minute.ago))
  end
end
