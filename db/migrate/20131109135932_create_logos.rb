class CreateLogos < ActiveRecord::Migration
  def change
    create_table :logos do |t|
      t.belongs_to :user
      t.timestamps
    end
  end
end
