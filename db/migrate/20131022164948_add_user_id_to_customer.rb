class AddUserIdToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :user_id, :string
  end
end
