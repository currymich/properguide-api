class OrderItemsController < ApplicationController
  def create
    @order = current_order
    @order.order_items.new(order_item_params)

    if @order.save!
      session[:order_id] = @order.id
      render json: {status: 201, order_items: @order.order_items}
    else
      render json: {status: 422}
    end
  end

  def update
    @order = current_order
    @order_item = @order.order_items.find(params[:id])

    if @order_item.update(order_item_params)
      @order_items = @order.order_items
      render json: {status: 201, order_items: @order.order_items}
    else
      render json: {status: 422}
    end
  end

  def destroy
    @order = current_order
    @order_item = @order.order_items.find(params[:id])

    @order_item.destroy
    @order_items = @order.order_items
    render json: {status: 204, order_items: @order.order_items}
  end

  private

    def order_item_params
      params.require(:order_item).permit(:quantity, :product_id)
    end
end
