class PaymentsController < ApplicationController
  def create
    @order = Order.find(params[:order_id])
    @payment = @order.payments.new(payment_params)
    if @payment.save!
      render json: {status: 201, payments: Payment.all, order: @order, payment: @payment}
    else
      render json: {status: 422}
    end

    rescue ActiveRecord::RecordNotFound => error
      render json: {error: "Order not found"}
  end

  private

    def payment_params
      params.required(:payment).permit(:amount, :description)
    end
end
