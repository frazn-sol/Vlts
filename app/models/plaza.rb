class Plaza < ActiveRecord::Base
  attr_accessible :description, :latitude, :location, :longitude, :name
  belongs_to :customer
  has_many :floors
end
