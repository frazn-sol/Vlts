class CreateVehicles < ActiveRecord::Migration
  def change
    create_table :vehicles do |t|
      t.string :platenumber
      t.string :driver_first_name
      t.string :driver_middle_name
      t.string :driver_last_name
      t.date :permit_date
      t.date :expiry_date
      t.string :badge_number
      t.boolean :visitor, :default => false
      t.belongs_to :oganization
      
      t.timestamps
    end
  end
end
