class Floor < ActiveRecord::Base
  attr_accessible :description, :name
  belongs_to :plaza
  has_many :slots
end
