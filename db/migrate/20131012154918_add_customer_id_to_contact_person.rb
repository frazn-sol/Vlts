class AddCustomerIdToContactPerson < ActiveRecord::Migration
  def change
    add_column :contact_people, :customer_id, :string
  end
end
