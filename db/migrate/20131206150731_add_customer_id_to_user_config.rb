class AddCustomerIdToUserConfig < ActiveRecord::Migration
  def change
    add_column :user_configs, :customer_id, :integer
  end
end
