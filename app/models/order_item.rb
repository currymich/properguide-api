class OrderItem < ApplicationRecord
  belongs_to :product
  belongs_to :order

  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validate :product_present
  validate :order_present

  before_save :finalize
  after_save :save_parents

  def update_quantity=(quantity)
    self[:quantity] = quantity
    self.save
  end

protected

  def update_total
    self[:total_price] = self[:quantity] * self[:unit_price]
  end

  def save_parents
    order.save
    product.save
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
    self[:unit_price] = product.price
    self[:unit_name] = product.name
    self[:image_url] = product.image_url
    self[:alt_image] = product.alt_image
    update_total
  end
end
