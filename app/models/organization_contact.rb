class OrganizationContact < ActiveRecord::Base
	audited
  attr_accessible :cell, :designation, :email, :first_name, :last_name, :middle_name, :phone, :organization_id
end
