class CreatePlazas < ActiveRecord::Migration
  def change
    create_table :plazas do |t|
      t.string :name
      t.string :description
      t.string :location
      t.string :latitude
      t.string :longitude
      t.belongs_to :customer

      t.timestamps
    end
  end
end
