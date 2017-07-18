class Payment < ApplicationRecord
  belongs_to :order

  after_save :save_parent
  after_destroy :save_parent

  def save_parent
    order.save
  end
end
