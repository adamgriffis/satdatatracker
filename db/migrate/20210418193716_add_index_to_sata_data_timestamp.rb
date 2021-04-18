class AddIndexToSataDataTimestamp < ActiveRecord::Migration[6.1]
  def change
    add_index :satellite_data, :timestamp
  end
end
