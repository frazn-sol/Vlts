class RemoveCompanynameFromContactPeople < ActiveRecord::Migration
  def up
    remove_column :contact_people, :companyname
      end

  def down
    add_column :contact_people, :companyname, :string
  end
end
