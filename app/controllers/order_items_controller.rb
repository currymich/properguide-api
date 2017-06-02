class OrderItemsController < ApplicationController
  before_action :authenticate

  def index
    @order = Order.find(params[:order_id])

    render json: {order_items: @order.order_items, order: @order}

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Order not found"}
  end

  def create
    @order = Order.find(params[:order_id])

    if @order.order_items.where(product_id: params[:order_item][:product_id]).empty?

      if @order.order_items.create!(order_item_params)
        render json: {status: 201, order_items: @order.order_items, order: @order}
      else
        render json: {status: 422}
      end

    else

      @order_item = @order.order_items.find_by(product_id: params[:order_item][:product_id])

      if @order_item.update(quantity: @order_item.quantity.to_i + params[:order_item][:quantity].to_i)
        render json: {status: 201, order_items: @order.order_items, order: @order}
      else
        render json: {status: 422}
      end

    end

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Order not found"}
  end

  def update
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      render json: {status: 201, order_items: @order.order_items, order: @order}
    else
      render json: {status: 422}
    end

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Order not found"}
  end

  def destroy
    @order = Order.find(params[:order_id])
    @order_item = @order.order_items.find(params[:id])

    @order_item.destroy
    render json: {status: 204, order_items: @order.order_items, order: @order}
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id)
    end
end
