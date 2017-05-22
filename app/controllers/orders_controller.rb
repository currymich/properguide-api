class OrdersController < ApplicationController
  before_action :authenticate

  def index
    render json: {orders: Order.all}
  end

  def create
    @order = Order.new(order_params)

    if @order.save!
      render json: {status: 201, orders: Order.all}
    else
      render json: {status: 422}
    end
  end

  def destroy
    @order = Order.find(params[:id])

    @order.destroy!
    render json: {status: 204, orders: Order.all}

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Order not found"}
  private

    def order_params
      params.required(:order).permit(:order_status_id, :dentist_id, :patient_name)
    end
end
