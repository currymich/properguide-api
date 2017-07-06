class BraintreeController < ApplicationController
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = ENV['merchant_id'] || 'xb49ksnfwzgbp922'
  Braintree::Configuration.public_key = ENV['public_key'] ||'t8s3k7d2hfykc32k'
  Braintree::Configuration.private_key = ENV['private_key'] ||'7e5cfc1a293ae2f8ffdfd198a0382ae6'

  def client_token
    if current_user
      begin
        @dentist = Order.find(params[:order_id]).dentist
        @customer = Braintree::Customer.find(@dentist.id)
      rescue Braintree::NotFoundError => e
        @customer = Braintree::Customer.create(
          :first_name => @dentist.name,
          :id => @dentist.id
        )
      end

      @token = Braintree::ClientToken.generate(
        :customer_id => @dentist.id,
        :options => {
          :verify_card => true
        }
      )

      render json: {
        token: @token
      }
    else
      render json: {
        status: 401, message: "unauthorized"
      }
    end
  end

  def checkout
    if current_user

      @nonce = params[:nonce]
      @order = Order.find(params[:order_id])
      @dentist = @order.dentist

      result = Braintree::Transaction.sale(
        :customer_id => @dentist.id,
        :amount => @order.total,
        :payment_method_nonce => @nonce,
        :options => {
          :submit_for_settlement => true
        }
      )

      if result.success?
        render json: {message: "Payment processed successfully for amount #{@order.total}", payment: @order.total, status: 202}
      else
        render json: {message: "Payment failed", status: 406}
      end
    else
      render json: {
        status: 401, message: "unauthorized"
      }
    end
  end
end
