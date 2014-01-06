class AddParkingTimeAndRemarksAndRemoveFlagToVehicleHistory < ActiveRecord::Migration
  def change
    add_column :vehicle_histories, :parking_time, :string
    add_column :vehicle_histories, :remarks, :string
    add_column :vehicle_histories, :remove_flag, :boolean
  end
end
