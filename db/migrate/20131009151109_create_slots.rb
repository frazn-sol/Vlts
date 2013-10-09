class CreateSlots < ActiveRecord::Migration
  def change
    create_table :slots do |t|
      t.string :name
      t.string :description
      t.belongs_to :floor

      t.timestamps
    end
  end
end
