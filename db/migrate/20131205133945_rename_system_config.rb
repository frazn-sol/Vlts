class RenameSystemConfig < ActiveRecord::Migration
  def self.up
    rename_table :system_config, :system_configs
  end
    
  def self.down
    rename_table :system_configs, :system_config
  end
end
