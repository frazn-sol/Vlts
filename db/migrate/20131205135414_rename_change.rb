class RenameChange < ActiveRecord::Migration
	def self.up
    	rename_table :changes, :user_configs
  	end
    
  def self.down
    rename_table :user_configs, :changes
  end
end
