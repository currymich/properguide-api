class CartsController < ApplicationController
  def show
    render json: {order_items: current_order.order_items}
  end
end
