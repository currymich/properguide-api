class Payment < ApplicationRecord
  belongs_to :order

  after_save order.save
end
