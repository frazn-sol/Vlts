class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.belongs_to :admin
      t.belongs_to :business_manager	
      t.timestamps
    end
  end
end
