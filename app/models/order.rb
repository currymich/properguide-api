class Order < ApplicationRecord
  belongs_to :order_status
  belongs_to :dentist
  has_many :order_items, dependent: :destroy
  has_many :products, through: :order_items
  before_create :set_order_status
  before_save :update_subtotal, :update_tax, :update_count, :update_total, :finalize

  def count
    order_items.count
  end

  def subtotal
    order_items.collect { |oi| oi.valid? ? oi.total_price : 0 }.sum
  end

  def tax
    0.09 * subtotal
  end

  def shipping
    10.0
  end

  def total
    self[:subtotal]*(1+self[:tax])+ self[:shipping]
  end

  def set_order_status(id=1)
    self[:order_status_id] = id
  end

  private
    def update_subtotal
      self[:subtotal] = subtotal
    end

    def update_count
      self[:count] = count
    end

    def update_tax
      self[:tax] = tax
    end

    def update_total
      self[:total] = total
    end

    def finalize
      self[:count] = count
      self[:tax] = tax
      self[:shipping] = shipping
      self[:total] = total
    end
end
