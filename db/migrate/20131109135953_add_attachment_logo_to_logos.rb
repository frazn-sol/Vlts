class AddAttachmentLogoToLogos < ActiveRecord::Migration
  def self.up
    change_table :logos do |t|
      t.attachment :logo
    end
  end

  def self.down
    drop_attached_file :logos, :logo
  end
end
