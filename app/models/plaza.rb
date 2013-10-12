class Plaza < ActiveRecord::Base
  attr_accessible :description, :latitude, :location, :longitude, :name, :customer_id
  belongs_to :customer
  has_many :floors
end
