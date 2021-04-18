class CreateSatelliteData < ActiveRecord::Migration[6.1]
  def change
    create_table :satellite_data do |t|
      t.datetime :timestamp
      t.decimal :altitude, precision: 20, scale: 10 # don't think we're going to have this kind of precision, considering we're just looking for 
      # average > < 160 KM it's overkill but no harm in saving it for later?

      t.timestamps
    end
  end
end
