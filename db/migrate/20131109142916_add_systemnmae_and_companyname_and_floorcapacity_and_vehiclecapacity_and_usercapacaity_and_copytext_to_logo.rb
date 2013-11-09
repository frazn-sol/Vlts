class AddSystemnmaeAndCompanynameAndFloorcapacityAndVehiclecapacityAndUsercapacaityAndCopytextToLogo < ActiveRecord::Migration
  def change
    add_column :logos, :systemname, :string
    add_column :logos, :companyname, :string
    add_column :logos, :floorcapacity, :integer
    add_column :logos, :vehiclecapacity, :integer
    add_column :logos, :usercapacity, :integer
    add_column :logos, :copytext, :text
  end
end
