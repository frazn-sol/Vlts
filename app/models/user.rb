class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :encryptable, :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :children, class_name: "User", foreign_key: "parent_id"
  belongs_to :parent, class_name: "User"

  belongs_to :customer
  has_many :customers

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :cell, :first_name, :last_name, :middle_name, :phone, :role, :passwordhint, :employeeno, :parent_id
end
