class BraintreeController < ApplicationController
  Braintree::Configuration.environment = :sandbox
  Braintree::Configuration.merchant_id = ENV['merchant_id'] || 'xb49ksnfwzgbp922'
  Braintree::Configuration.public_key = ENV['public_key'] ||'t8s3k7d2hfykc32k'
  Braintree::Configuration.private_key = ENV['private_key'] ||'7e5cfc1a293ae2f8ffdfd198a0382ae6'

  def client_token
    if current_user
      begin
        @customer = Braintree::Customer.find(current_user.id)
      rescue Braintree::NotFoundError => e
        @dentist = User.find(current_user.id).dentist
        @customer = Braintree::Customer.create(
          :first_name => @dentist.name,
          :id => current_user.id
        )
      end

      @token = Braintree::ClientToken.generate(
        :customer_id => current_user.id,
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

      result = Braintree::Transaction.sale(
        :customer_id => current_user.id,
        :amount => @order.total,
        :payment_method_nonce => @nonce,
        :options => {
          :submit_for_settlement => true
        }
      )

      if result.success?
        render json: {message: "Payment processed successfully for amount #{@order.total}", order: @order}
      else
        render json: {message: "Payment failed"}
      end
    else
      render json: {
        status: 401, message: "unauthorized"
      }
    end
  end
end