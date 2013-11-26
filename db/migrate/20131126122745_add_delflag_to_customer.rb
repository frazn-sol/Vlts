class AddDelflagToCustomer < ActiveRecord::Migration
  def change
    add_column :customers, :delflag, :boolean, :default => false
  end
end
