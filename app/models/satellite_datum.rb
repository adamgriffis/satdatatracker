class SatelliteDatum < ApplicationRecord
  validates_presence_of  :altitude
  validates_presence_of  :timestamp # no point in having a duplicate timestamp, no point in having a record without at timestam and altitude
  validates :timestamp, uniqueness: true
end
