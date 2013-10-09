class Slot < ActiveRecord::Base
  attr_accessible :description, :name
  belongs_to :floor
end
