class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.belongs_to :admin
      t.belongs_to :customer	
      t.timestamps
    end
  end
end
