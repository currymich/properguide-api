class CartsController < ApplicationController
  before_action :authorize_cart

  def show
    @order = current_order
    render json: {order_items: @order.order_items}
  end
end
