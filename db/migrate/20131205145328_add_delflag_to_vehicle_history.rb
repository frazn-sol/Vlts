class AddDelflagToVehicleHistory < ActiveRecord::Migration
  def change
    add_column :vehicle_histories, :delflag, :boolean, :default => false
  end
end
