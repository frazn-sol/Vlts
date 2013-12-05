class RenameLogo < ActiveRecord::Migration
  def self.up
    rename_table :logos, :system_config
  end
    
  def self.down
    rename_table :system_config, :logos
  end
end
