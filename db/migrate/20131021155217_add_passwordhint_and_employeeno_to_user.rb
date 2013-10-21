class AddPasswordhintAndEmployeenoToUser < ActiveRecord::Migration
  def change
    add_column :users, :passwordhint, :string
    add_column :users, :employeeno, :string
  end
end
