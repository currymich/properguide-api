class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :dentist
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  has_many :payments, dependent: :destroy

  before_save :finalize

protected

  def update_order_status
    status_id = self[:order_status_id]
    self[:order_status] = OrderStatus.find(status_id).name
  end

  def update_count
    self[:count] = order_items.collect { |oi| oi.valid? ? oi.quantity : 0 }.sum
  end

  def update_subtotal
    self[:subtotal] = order_items.collect { |oi| oi.valid? ? oi.total_price : 0 }.sum
  end

  def update_tax
    self[:tax] = (dentist.tax_rate/100) * subtotal
  end

  def update_shipping(shipping)
    self[:shipping] = shipping
  end

  def update_total
    self[:total] = (self[:shipping] + self[:tax] + self[:subtotal]).round(2)
  end

private

  def finalize
    self[:dentist_name] = Dentist.find(dentist_id).name
    self[:shipping] = 0
    update_order_status
    update_subtotal
    update_count
    update_tax
    update_total
  end
end
