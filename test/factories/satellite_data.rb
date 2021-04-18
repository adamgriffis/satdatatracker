# Read about fixtures at https://api.rubyonrails.org/classes/ActiveRecord/FixtureSet.html
FactoryBot.define do
  factory :satellite_datum, class: SatelliteDatum do 
    altitude { 100 }
    timestamp { Time.now }
  end

  factory :data_150, class: SatelliteDatum do 
    altitude { 150.15 }
    timestamp { Time.now }
  end

  factory :data_160, class: SatelliteDatum do 
    altitude { 160.16 }
    timestamp { Time.now }
  end

  factory :data_170, class: SatelliteDatum do 
    altitude { 170.17 }
    timestamp { Time.now }
  end
end