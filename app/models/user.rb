class User < ApplicationRecord
  validates :email, :username, presence: true, uniqueness: true
  has_secure_password

  has_many :orders
end
