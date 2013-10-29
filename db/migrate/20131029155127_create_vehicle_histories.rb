class CreateVehicleHistories < ActiveRecord::Migration
  def change
    create_table :vehicle_histories do |t|
      t.string :slot
      t.belongs_to :floor
	  t.belongs_to :location
	  t.belongs_to :vehicle	

      t.timestamps
    end
  end
end
