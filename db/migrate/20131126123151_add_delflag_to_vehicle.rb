class AddDelflagToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :delflag, :boolean, :default => false
  end
end
