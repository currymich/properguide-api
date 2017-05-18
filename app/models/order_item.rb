class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  before_save :finalize

  def unit_price
    product.price
  end

  def unit_name
    product.name
  end

  def image_url
    product.image_url
  end

  def total_price
    unit_price * quantity
  end

private

  def product_present
    if product.nil?
      errors.add(:product, "is not valid or is not active.")
    end
  end

  def order_present
    if order.nil?
      errors.add(:order, "is not a valid order.")
    end
  end

  def finalize
    self[:unit_name] = unit_name
    self[:unit_price] = unit_price
    self[:image_url] = image_url
    self[:total_price] = quantity * self[:unit_price]
  end
end
