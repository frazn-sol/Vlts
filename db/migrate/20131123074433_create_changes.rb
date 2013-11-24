class CreateChanges < ActiveRecord::Migration
  def change
    create_table :changes do |t|
      t.integer :user_id
      t.integer :vehiclecapacity
      t.integer :floorcapacity
      t.integer :usercapacity

      t.timestamps
    end
  end
end
