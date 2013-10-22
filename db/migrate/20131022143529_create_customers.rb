class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :company_name
      t.string :address1
      t.string :address2
      t.string :state
      t.string :zipcode
      t.string :phone1
      t.string :phone2
      t.string :web

      t.timestamps
    end
  end
end
