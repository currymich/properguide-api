class PaymentController < ApplicationController
  def create
    @payment = Payment.new(payment_params)
    if @payment.save!
      render json: {status: 201, payments: Payment.all}
    else
      render json: {status: 422}
    end
  end

  private

    def payment_params
      params.required(:payment).permit(:order_id, :amount, :description)
    end
end
