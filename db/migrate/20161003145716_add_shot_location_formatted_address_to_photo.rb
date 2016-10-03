class AddShotLocationFormattedAddressToPhoto < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :shot_location_formatted_address, :string
  end
end
