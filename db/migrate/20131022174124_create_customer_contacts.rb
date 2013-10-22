class CreateCustomerContacts < ActiveRecord::Migration
  def change
    create_table :customer_contacts do |t|
      t.string :first_name
      t.string :middle_name
      t.string :last_name
      t.string :designation
      t.string :phone
      t.string :cell
      t.string :email
      t.belongs_to :customer

      t.timestamps
    end
  end
end
