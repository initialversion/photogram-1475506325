class AddShotLocationLatitudeToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :shot_location_latitude, :float
  end
end
