class CreateFloors < ActiveRecord::Migration
  def change
    create_table :floors do |t|
      t.string :name
      t.string :description
      t.belongs_to :plaza

      t.timestamps
    end
  end
end
