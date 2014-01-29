class SystemConfig < ActiveRecord::Base
	belongs_to :user
	attr_accessible :user_id, :logo, :companyname, :systemname, :floorcapacity, :vehiclecapacity, :usercapacity, :copytext, :to, :from
  	has_attached_file :logo, :styles => { :medium => "227x60>", :thumb => "100x100>" }
  # attr_accessible :title, :body
end
