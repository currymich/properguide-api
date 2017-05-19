class User < ApplicationRecord
  validates :email, :username, presence: true, uniqueness: true
  has_secure_password
end
