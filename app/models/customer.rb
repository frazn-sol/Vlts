class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :validatable

  belongs_to :admin
  has_many :vehicles

  has_many :customers
  belongs_to :customer
  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me, :name, :address1, :address2,
                  :city, :state, :zipcode, :phone1, :phone2, :website, :role, :username, :passwordhint
  # attr_accessible :title, :body
end
