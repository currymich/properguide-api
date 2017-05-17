class CartsController < ApplicationController
  def show
    @order = current_order
    render json: {order_items: @order.order_items}
  end
end
