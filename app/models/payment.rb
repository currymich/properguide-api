class Payment < ApplicationRecord
  belongs_to :order

  after_save :save_parent

  def save_parent
    order.save
  end
end
