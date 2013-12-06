class UserConfig < ActiveRecord::Base
  attr_accessible :floorcapacity, :user_id, :usercapacity, :vehiclecapacity, :customer_id
end
