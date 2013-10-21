class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :vehicle_name
      t.string :badge_number
      t.string :organization
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.timestamps
    end
  end
end
