class AddToAndFromToSystemConfig < ActiveRecord::Migration
  def change
    add_column :system_configs, :to, :string
    add_column :system_configs, :from, :string
  end
end
