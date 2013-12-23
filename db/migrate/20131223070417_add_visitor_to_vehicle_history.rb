class AddVisitorToVehicleHistory < ActiveRecord::Migration
  def change
    add_column :vehicle_histories, :visitor, :string
  end
end
