class AddDelflagToCustomerContact < ActiveRecord::Migration
  def change
    add_column :customer_contacts, :delflag, :boolean, :default => false
  end
end
