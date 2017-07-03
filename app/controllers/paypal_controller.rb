class PaypalController < ApplicationController
  # client: ENV['paypal_sandbox_client']
  # production: ENV['paypal_live_client']

  def create
    @order = Order.find(params[:order_id])
    @payment = HTTParty.post(
      "https://api.sandbox.paypal.com/v1/payments/payment", {
        :headers => { 'Content-Type' => 'application/json' },
        :body => {
          :intent => 'sale',
          :payer => {
            :payment_method => "paypal"
          },
          :transactions => {
            :amount => {
              :total => @order[:total],
              :currency => "USD",
              :details =>  {
                :subtotal => @order[:subtotal],
                :shipping => @order[:shipping],
                :tax => @order[:tax],
              }
            },
          }
        }.to_json
      })
  end

  def execute

  end
end
