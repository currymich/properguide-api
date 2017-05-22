class OrderController < ApplicationController
  def index
    render json: {orders: Order.all}
  end

  def show
    render json: {order: Order.find(params[:id])}
  end

  def create
    @order = Order.new(order_params)

    if @order.save!
      render json: {status: 201, order: @order}
    else
      render json: {status: 422}
    end
  end
end
