class OrdersController < ApplicationController
  before_action :authenticate, except: [:index, :show, :statuses]

  def index
    render json: {status: 401, message: "unauthorized"} unless current_user

    if current_user.admin?
      render json: {admin: true, orders: Order.all}
    else
      @dentist = User.find(current_user.id).dentist
      @orders = @dentist.orders

      render json: {admin: false, orders: @orders, dentist_id: @dentist.id}
    end

  rescue ActiveRecord::RecordNotFound => error
    render json: {error: "Dentist not found"}
  end

  def show
    @order = Order.find(params[:id])

    render json: {status: 401, message: "unauthorized"} unless current_user && (current_user.id == @order.dentist.user.id || current_user.admin?)

    render json: {order: @order, dentist: @order.dentist}

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Order not found"}
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
  end

  def update
    @order = Order.find(params[:id])

    if @order.update(order_params)
      render json:{status: 200, message: "Order updated", order: @order}
    else
      render json:{status: 422, message: "Couldn't process updated params"}
    end
  end

  def statuses
    render json: {statuses: OrderStatus.all}
  end

  private

    def order_params
      params.required(:order).permit(:order_status_id, :dentist_id, :patient_name, :due_date, :instructions)
    end
end
