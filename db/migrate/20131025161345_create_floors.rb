class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.string :nickname
      t.string :description
      t.string :capacity
      t.string :occupied
      t.belongs_to :location

      t.timestamps
    end
  end
end
