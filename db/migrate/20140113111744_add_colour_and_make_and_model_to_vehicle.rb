class AddColourAndMakeAndModelToVehicle < ActiveRecord::Migration
  def change
    add_column :vehicles, :colour, :string
    add_column :vehicles, :make, :string
    add_column :vehicles, :model, :string
  end
end
