class AddPlatenumberToVehicleHistory < ActiveRecord::Migration
  def change
    add_column :vehicle_histories, :platenumber, :string
  end
end
