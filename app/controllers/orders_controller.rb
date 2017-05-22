class OrdersController < ApplicationController
  before_action :authenticate

  def index
    render json: {orders: Order.all}
  end

  def show
    render json: {order: Order.find(params[:id])}

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Order not found"}
  end

  def create
    @order = Order.new(order_params)

    if @order.save!
      render json: {status: 201, order: @order}
    else
      render json: {status: 422}
    end
  end

  private

    def order_params
      params.required(:order).permit(:order_status_id, :dentist_id, :patient_name)
    end
end
