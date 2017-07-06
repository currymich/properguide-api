class Dentist < ApplicationRecord
  validates :name, presence: true
  has_many :orders, dependent: :destroy
  has_one :user, dependent: :destroy
  has_many :payments, through: :orders
end
