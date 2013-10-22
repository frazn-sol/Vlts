class CustomerContact < ActiveRecord::Base
  belongs_to :customer
  attr_accessible :cell, :designation, :email, :first_name, :last_name, :middle_name, :phone
end
